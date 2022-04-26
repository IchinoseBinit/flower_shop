import 'package:flower_shop/models/order.dart';
import 'package:flower_shop/providers/product_provider.dart';
import 'package:flower_shop/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.order,
  }) : super(key: key);

  final double width, aspectRetio;
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            padding: EdgeInsets.all(
              3.h,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(
              Provider.of<ProductsProvider>(context, listen: false)
                  .getProductById(order.product)
                  .productImage,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Provider.of<ProductsProvider>(context, listen: false)
                  .getProductById(order.product)
                  .productName,
              maxLines: 2,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              DateFormat("yyyy MMM dd hh:mm a").format(order.shippingTime),
              maxLines: 2,
            ),
          ],
        ),
        const Spacer(),
        Text("Quantity: ${order.quantity.toString()}"),
      ],
    );
  }
}
