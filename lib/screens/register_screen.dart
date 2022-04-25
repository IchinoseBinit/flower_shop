import 'package:flutter/material.dart';
import '/providers/register_provider.dart';
import 'package:provider/provider.dart';
import '/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/utils/validation_mixin.dart';
import '/widgets/general_alert_dialog.dart';
import '/widgets/general_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
                title: "Full Name",
                controller: fullnameController,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validate: (value) =>
                    ValidationMixin().validate(value!, "Full Name"),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: 16.h,
              ),

              GeneralTextField(
                title: "Username",
                controller: usernameController,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validate: (value) =>
                    ValidationMixin().validate(value!, "Username"),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                title: "Email",
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validate: (value) => ValidationMixin().validateEmail(value!),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                title: "Address",
                controller: addressController,
                textInputType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                validate: (value) =>
                    ValidationMixin().validate(value!, "Address"),
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
                textInputAction: TextInputAction.next,
                validate: (value) => ValidationMixin().validatePassword(value!),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(height: 16.h),
              GeneralTextField(
                title: "Confirm Password",
                isObscure: true,
                controller: confirmPasswordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validate: (value) => ValidationMixin().validatePassword(
                    passwordController.text,
                    isConfirmPassword: true,
                    confirmValue: value!),
                onFieldSubmitted: (_) {
                  submit(context);
                },
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () async {
                  await submit(context);
                },
                child: const Text("Register"),
              ),
              SizedBox(height: 16.h),

              const Text("OR"),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already Have an Account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }

  submit(context) async {
    final dialog = GeneralAlertDialog();
    try {
      if (formKey.currentState!.validate()) {
        dialog.customLoadingDialog(context);
        await Provider.of<RegisterProvider>(context, listen: false)
            .registerUser(
          context,
          email: emailController.text,
          username: usernameController.text,
          password: passwordController.text,
          address: addressController.text,
          fullName: fullnameController.text,
        );
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (ex) {
      Navigator.pop(context);
      dialog.customAlertDialog(context, ex.toString());
    }
  }
}
