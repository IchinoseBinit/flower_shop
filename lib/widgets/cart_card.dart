import 'package:flower_shop/models/product.dart';
import 'package:flower_shop/providers/cart_provider.dart';
import 'package:flower_shop/screens/payment_screen.dart';
import 'package:flower_shop/utils/custom_toast_animation.dart';
import 'package:flower_shop/utils/navigate.dart';
import 'package:flower_shop/widgets/general_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  const CartCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              6,
            ),
          ),
          child: Image.network(
            product.productImage,
            height: 80.h,
            width: 120.w,
            errorBuilder: ((context, error, stackTrace) => const Icon(
                  Icons.error_outlined,
                )),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.productName),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .updateQuantity(product.id);
                  },
                  icon: const Icon(
                    Icons.add_outlined,
                    size: 16,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Consumer<CartProvider>(builder: (context, value, _) {
                  return Text(value
                      .getProductById(product.id)
                      .selectedQuantity
                      .toString());
                }),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .updateQuantity(
                      product.id,
                      isAdded: false,
                    );
                  },
                  icon: const Icon(
                    Icons.remove_outlined,
                    size: 16,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Text("Rs. ${product.price * product.selectedQuantity}"),
        SizedBox(
          width: 2.w,
        ),
        IconButton(
          onPressed: () async {
            GeneralAlertDialog().customLoadingDialog(context);
            await Provider.of<CartProvider>(context, listen: false).postOrder(
              context,
              product.id,
            );
            Navigator.pop(context);
            await showDialog(
              barrierColor: Colors.grey.withOpacity(0.2),
              context: context,
              builder: (context) {
                Future.delayed(Duration(milliseconds: 2100), () {
                  Navigator.of(context).pop(true);
                });

                return const CustomAnimatedToast();
              },
            );
            navigate(context,
                Consumer<CartProvider>(builder: (context, value, _) {
              return PaymentScreen(
                price: value.getProductById(product.id).selectedQuantity *
                    product.price.toInt(),
                productName: product.productName,
                productid: product.id,
                quantity: value.getProductById(product.id).selectedQuantity,
              );
            }));
          },
          icon: const Icon(
            Icons.shopping_cart_checkout_outlined,
          ),
        )
      ],
    );
  }
}