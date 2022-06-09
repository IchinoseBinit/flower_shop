import 'package:flower_shop/widgets/one_details_displayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/providers/login_provider.dart';
import '/utils/validation_mixin.dart';
import '/widgets/curved_body_widget.dart';
import '/widgets/general_text_field.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginProvider>(
      context,
    ).profile!;
    fullNameController.text = user.fullName;
    addressController.text = user.address;
    phoneController.text = user.phone;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your profile"),
      ),
      body: CurvedBodyWidget(
          widget: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      OneDetailDisplayer(
                        title: "Username",
                        value: user.username,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      OneDetailDisplayer(
                        title: "Email",
                        value: user.email,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                title: "Full Name",
                controller: fullNameController,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validate: (v) => ValidationMixin().validate(v!, "Full name"),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                title: "Address",
                controller: addressController,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validate: (v) => ValidationMixin().validate(v!, "Address"),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                title: "Phone Number",
                controller: phoneController,
                maxLength: 10,
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                validate: (v) => ValidationMixin().validateMobile(
                  v!,
                ),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: 16.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final map = {
                      "full_name": fullNameController.text,
                      "address": addressController.text,
                      "phone_num": phoneController.text
                    };
                    await Provider.of<LoginProvider>(context, listen: false)
                        .updateProfile(context, map: map);
                  }
                },
                child: const Text("Edit Profile"),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
