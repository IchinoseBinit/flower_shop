import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/providers/login_provider.dart';
import '/utils/validation_mixin.dart';
import '/widgets/curved_body_widget.dart';
import '/widgets/general_text_field.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: CurvedBodyWidget(
        widget: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                "Enter your old password to validate and set a new password",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                title: "Your old Password",
                isObscure: true,
                controller: oldPasswordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validate: (value) => ValidationMixin().validatePassword(
                  value!,
                ),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                title: "Your new Password",
                isObscure: true,
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
              GeneralTextField(
                title: "Confirm your Password",
                isObscure: true,
                controller: confirmPasswordController,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validate: (value) => ValidationMixin().validatePassword(value!,
                    isConfirmPassword: true,
                    confirmValue: passwordController.text),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: 16.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final map = {
                      "old_password": oldPasswordController.text,
                      "new_password": passwordController.text
                    };
                    await Provider.of<LoginProvider>(context, listen: false)
                        .changePassword(context, map: map);
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
