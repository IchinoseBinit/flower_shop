import 'package:flower_shop/constants/urls.dart';
import 'package:flutter/material.dart';
import '/api/api_call.dart';

class RegisterProvider extends ChangeNotifier {
  registerUser(
    BuildContext context, {
    required String email,
    required String username,
    required String password,
    required String address,
    required String fullName,
  }) async {
    try {
      final map = {
        "email": email,
        "username": username,
        "password": password,
        "address": address,
        "full_name": fullName,
      };

      await APICall().postRequestWithoutToken(registerUrl, map);
    } catch (ex) {
      rethrow;
    }
  }
}
