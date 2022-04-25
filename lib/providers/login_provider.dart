import 'package:flower_shop/api/api_client.dart';
import 'package:flower_shop/constants/urls.dart';
import 'package:flower_shop/models/user.dart';
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
}
