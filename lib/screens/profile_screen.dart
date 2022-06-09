import 'package:flower_shop/screens/edit_profile_screen.dart';
import 'package:flower_shop/utils/navigate.dart';
import 'package:flower_shop/widgets/one_details_displayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/providers/login_provider.dart';
import '/utils/validation_mixin.dart';
import '/widgets/curved_body_widget.dart';
import '/widgets/general_text_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginProvider>(
      context,
    ).profile!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your profile"),
        actions: [
          IconButton(
            onPressed: () => navigate(context, EditProfileScreen()),
            icon: const Icon(
              Icons.edit_outlined,
            ),
          ),
        ],
      ),
      body: CurvedBodyWidget(
          widget: SingleChildScrollView(
        child: Column(
          children: [
            buildListTile(
              label: "Username",
              value: user.username,
              iconData: Icons.manage_accounts_sharp,
            ),
            buildListTile(
              label: "Full Name",
              value: user.fullName,
              iconData: Icons.person,
            ),
            if (user.phone.isNotEmpty)
              buildListTile(
                label: "Phone",
                value: user.phone,
                iconData: Icons.phone,
              ),
            buildListTile(
              label: "Email Address",
              value: user.email,
              iconData: Icons.email_outlined,
            ),
            buildListTile(
              label: "Address",
              value: user.address,
              iconData: Icons.location_on_outlined,
            ),
          ],
        ),
      )),
    );
  }

  Widget buildListTile({
    required String label,
    required String value,
    required IconData iconData,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: ListTile(
        leading: Icon(
          iconData,
        ),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        trailing: Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
