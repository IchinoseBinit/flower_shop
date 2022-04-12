import 'package:flutter/material.dart';
import '/api/api_call.dart';

class LoginProvider extends ChangeNotifier {
  loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final map = {"username": username, "password": password};

      await APICall().postRequestWithoutToken(map);
    } catch (ex) {
      rethrow;
    }
  }
}
