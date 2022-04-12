import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/widgets/curved_body_widget.dart';
import '/widgets/one_details_displayer.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isKhalti = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: CurvedBodyWidget(
        widget: ListView(
          children: [
            const Text("Order Details"),
            SizedBox(
              height: 16.h,
            ),
            const OneDetailDisplayer(title: "Product Name", value: "Rose Bud"),
            SizedBox(
              height: 8.h,
            ),
            const OneDetailDisplayer(title: "Quantity", value: "3"),
            SizedBox(
              height: 8.h,
            ),
            const OneDetailDisplayer(title: "Total Amount", value: "Rs. 1250"),
            SizedBox(
              height: 8.h,
            ),
            const Divider(),
            SizedBox(
              height: 8.h,
            ),
            const Text("Select Payment Method"),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: isKhalti,
                  onChanged: (bool? val) {
                    isKhalti = val!;
                    setState(() {});
                  },
                ),
                SizedBox(
                  width: 5.w,
                ),
                const Text("Khalti")
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Radio<bool>(
                  value: false,
                  groupValue: isKhalti,
                  onChanged: (bool? val) {
                    isKhalti = val!;
                    setState(() {});
                  },
                ),
                SizedBox(
                  width: 5.w,
                ),
                const Text("Cash on Delivery")
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Proceed"),
            ),
          ],
          shrinkWrap: true,
          primary: false,
        ),
      ),
    );
  }
}
