import 'package:flower_shop/widgets/curved_body_widget.dart';
import 'package:flower_shop/widgets/one_details_displayer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  // final

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
      ),
      body: CurvedBodyWidget(
        widget: ListView(
          children: [
            Stack(
              children: [
                Image.asset(
                  "name",
                  height: 200.h,
                  width: 400.w,
                ),
                Positioned(
                  bottom: 5.h,
                  right: 5.w,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_outlined,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            const OneDetailDisplayer(title: "Product Name", value: "Rose Bud"),
            SizedBox(
              height: 8.h,
            ),
            const OneDetailDisplayer(title: "Price", value: "Rs. 1250"),
            SizedBox(
              height: 8.h,
            ),
            const Divider(),
            SizedBox(
              height: 8.h,
            ),
            const Text("Description"),
            SizedBox(
              height: 4.h,
            ),
            const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.,"),
          ],
          shrinkWrap: true,
          primary: false,
        ),
      ),
    );
  }
}
