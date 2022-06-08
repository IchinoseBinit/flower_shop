import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/providers/login_provider.dart';
import '/utils/validation_mixin.dart';
import '/widgets/curved_body_widget.dart';
import '/widgets/general_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot password"),
      ),
      body: CurvedBodyWidget(
        widget: Column(
          children: [
            Text(
              "You can always reset your account by entering your email",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 16.h,
            ),
            Form(
              key: formKey,
              child: GeneralTextField(
                title: "Email",
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validate: (value) => ValidationMixin().validateEmail(value!),
                onFieldSubmitted: (_) {
                  Provider.of<LoginProvider>(context, listen: false)
                      .forgotPassword(context, email: emailController.text);
                },
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await Provider.of<LoginProvider>(context, listen: false)
                      .forgotPassword(context, email: emailController.text);
                }
              },
              child: const Text("Confirm Email"),
            ),
          ],
        ),
      ),
    );
  }
}
