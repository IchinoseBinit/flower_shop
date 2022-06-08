import 'package:flower_shop/api/api_client.dart';
import 'package:flower_shop/constants/urls.dart';
import 'package:flower_shop/models/user.dart';
import 'package:flower_shop/screens/confirm_forgot_password_screen.dart';
import 'package:flower_shop/screens/login_screen.dart';
import 'package:flower_shop/utils/navigate.dart';
import 'package:flower_shop/utils/request_type.dart';
import 'package:flower_shop/widgets/general_alert_dialog.dart';
import 'package:flutter/material.dart';
import '/api/api_call.dart';

class LoginProvider extends ChangeNotifier {
  User? user;
  loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final map = {"username": username, "password": password};

      user =
          userFromJson(await APICall().postRequestWithoutToken(loginUrl, map));
      APIClient.token = user!.token;
      notifyListeners();
    } catch (ex) {
      rethrow;
    }
  }

  logout(BuildContext context) async {
    try {
      GeneralAlertDialog().customLoadingDialog(context);
      await APICall().postRequestWithToken(logoutUrl, {});
      Navigator.pop(context);
      APIClient.token = "";
      user = null;
      navigateAndRemoveAll(context, LoginScreen());
    } catch (ex) {
      rethrow;
    }
  }

  changePassword(
    BuildContext context, {
    required Map map,
  }) async {
    try {
      GeneralAlertDialog().customLoadingDialog(context);
      await APICall().postRequestWithToken(
        changePasswordUrl,
        map,
        requestType: RequestType.putWithToken,
      );
      Navigator.pop(context);
      APIClient.token = "";
      user = null;
      navigateAndRemoveAll(context, LoginScreen());
    } catch (ex) {
      Navigator.pop(context);

      GeneralAlertDialog().customAlertDialog(context, ex.toString());
    }
  }

  forgotPassword(BuildContext context, {required String email}) async {
    try {
      GeneralAlertDialog().customLoadingDialog(context);
      final body = {
        "email": email,
      };
      await APICall().postRequestWithoutToken(
        passwordResetUrl,
        body,
      );
      Navigator.pop(context);
      navigate(context, ConfirmForgotPasswordScreen());
    } catch (ex) {
      Navigator.pop(context);
      GeneralAlertDialog().customAlertDialog(context, ex.toString());
    }
  }

  confirmForgotPassword(BuildContext context,
      {required String token, required String password}) async {
    try {
      GeneralAlertDialog().customLoadingDialog(context);
      final body = {
        "token": token,
        "password": password,
      };
      await APICall().postRequestWithoutToken(
        passwordResetConfirmUrl,
        body,
      );
      Navigator.pop(context);
      navigateAndRemoveAll(context, LoginScreen());
    } catch (ex) {
      Navigator.pop(context);
      GeneralAlertDialog().customAlertDialog(context, ex.toString());
    }
  }
}
