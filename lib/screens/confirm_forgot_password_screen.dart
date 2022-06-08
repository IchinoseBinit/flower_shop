import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/providers/login_provider.dart';
import '/screens/login_screen.dart';
import '/utils/navigate.dart';
import '/utils/validation_mixin.dart';
import '/widgets/curved_body_widget.dart';
import '/widgets/general_text_field.dart';
import 'package:provider/provider.dart';

class ConfirmForgotPasswordScreen extends StatelessWidget {
  ConfirmForgotPasswordScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final tokenController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Forgot Password"),
      ),
      body: CurvedBodyWidget(
        widget: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                "For validating your request, Please provide the token sent to your email address",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                title: "Your Token",
                controller: tokenController,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validate: (value) =>
                    ValidationMixin().validate(value!, "Token"),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                title: "Your new Password",
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validate: (value) => ValidationMixin().validatePassword(
                  value!,
                ),
                onFieldSubmitted: (_) {},
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await Provider.of<LoginProvider>(context, listen: false)
                        .confirmForgotPassword(context,
                            token: tokenController.text.trim(),
                            password: passwordController.text);
                  }
                },
                child: const Text("Change Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
