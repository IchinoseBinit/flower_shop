import 'package:flutter/material.dart';
import '/api/api_call.dart';

class RegisterProvider extends ChangeNotifier {
  registerUser(
    BuildContext context, {
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final map = {"email": email, "username": username, "password": password};

      await APICall().postRequestWithoutToken(map);
    } catch (ex) {
      rethrow;
    }
  }
}
