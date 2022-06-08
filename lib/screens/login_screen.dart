import 'package:flower_shop/screens/forgot_password_screen.dart';
import 'package:flower_shop/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/constants/constants.dart';
import '/providers/login_provider.dart';
import '/screens/home_screen.dart';
import '/screens/register_screen.dart';
import '/utils/validation_mixin.dart';
import '/widgets/general_alert_dialog.dart';
import '/widgets/general_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  // final bool canCheckBioMetric;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: basePadding,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Image.asset(
                //   ImageConstants.logo,
                //   width: SizeConfig.width * 40,
                //   height: SizeConfig.height * 25,
                // ),
                SizedBox(
                  height: 8.h,
                ),
                GeneralTextField(
                  title: "Username",
                  controller: usernameController,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validate: (value) => ValidationMixin().validate(
                    value!,
                    "Username",
                  ),
                  onFieldSubmitted: (_) {},
                ),
                SizedBox(
                  height: 16.h,
                ),
                GeneralTextField(
                  title: "Password",
                  isObscure: true,
                  controller: passwordController,
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validate: (value) =>
                      ValidationMixin().validatePassword(value!),
                  onFieldSubmitted: (_) {
                    _submit(context, false);
                  },
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => navigate(context, ForgotPasswordScreen()),
                    child: Text(
                      "Forgot your Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    _submit(context, false);
                  },
                  child: const Text("Login"),
                ),
                SizedBox(height: 16.h),
                const Text("OR"),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't Have an Account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text("Register"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context, bool isAuthenticated) async {
    final dialog = GeneralAlertDialog();

    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      dialog.customLoadingDialog(context);
      await Provider.of<LoginProvider>(context, listen: false).loginUser(
          username: usernameController.text, password: passwordController.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } catch (ex) {
      Navigator.pop(context);
      dialog.customAlertDialog(context, ex.toString());
    }
  }
}
