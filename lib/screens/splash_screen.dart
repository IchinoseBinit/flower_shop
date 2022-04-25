import '/screens/login_screen.dart';
import '/utils/navigate.dart';
import '/widgets/curved_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  navigateToLogin(BuildContext context) {
    Future.delayed(const Duration(seconds: 5))
        .then((_) => navigateUntil(context, LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    navigateToLogin(context);
    return Scaffold(
      body: SafeArea(
        child: CurvedBodyWidget(
            widget: Column(
          children: [
            Image.asset("name"),
            SizedBox(
              height: 16.h,
            ),
            const Text("Flower Shop"),
          ],
        )),
      ),
    );
  }
}
