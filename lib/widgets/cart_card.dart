import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_shop/models/order.dart';
import 'package:flower_shop/models/product.dart';
import 'package:flower_shop/providers/cart_provider.dart';
import 'package:flower_shop/providers/order_provider.dart';
import 'package:flower_shop/providers/product_provider.dart';
import 'package:flower_shop/screens/payment_screen.dart';
import 'package:flower_shop/screens/preview_screen.dart';
import 'package:flower_shop/utils/custom_toast_animation.dart';
import 'package:flower_shop/utils/navigate.dart';
import 'package:flower_shop/widgets/general_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  const CartCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            15,
          ),
          child: CachedNetworkImage(
            imageUrl: product.productImage,
            height: 80.h,
            width: 80.w,
            errorWidget: (context, error, stackTrace) => const Icon(
              Icons.error_outlined,
            ),
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
                Container(
                  width: 25.w,
                  height: 25.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .updateQuantity(product.id);
                    },
                    icon: const Icon(
                      Icons.add_outlined,
                      size: 24,
                    ),
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
                SizedBox(
                  width: 5.w,
                ),
                Container(
                  width: 25.w,
                  height: 25.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: IconButton(
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
          width: 5.w,
        ),
        IconButton(
          onPressed: () async {
            navigate(context, PreviewScreen(product: product), isPreview: true);
          },
          icon: const Icon(Icons.visibility_outlined),
        ),
        SizedBox(
          width: 1.w,
        ),
        IconButton(
          onPressed: () async {
            final isCashOnDelivery = await showPaymentBottomSheet(
              context,
            );
            if (isCashOnDelivery != null) {
              await makeOrder(context, isCashOnDelivery: isCashOnDelivery);
            }
          },
          icon: const Icon(
            Icons.shopping_cart_checkout_outlined,
          ),
        )
      ],
    );
  }

  makeOrder(BuildContext context, {bool isCashOnDelivery = true}) async {
    GeneralAlertDialog().customLoadingDialog(context);

    final order =
        await Provider.of<CartProvider>(context, listen: false).postOrder(
      context,
      product.id,
    );

    Navigator.pop(context);
    final price = Provider.of<ProductsProvider>(context, listen: false)
            .getProductById(product.id)
            .selectedQuantity *
        product.price.toInt();
    final amount = price * order.quantity;
    if (isCashOnDelivery) {
      navigate(context, Consumer<CartProvider>(builder: (context, value, _) {
        return PaymentScreen(
          price: amount,
          productName: product.productName,
          order: order,
        );
      }));
    } else {
      final config = makeConfig(amount.toInt());

      KhaltiScope.of(context).pay(
        config: config,
        preferences: [
          PaymentPreference.khalti,
        ],
        onSuccess: (successModel) async {
          try {
            GeneralAlertDialog().customLoadingDialog(context);
            await Provider.of<OrderProvider>(context, listen: false)
                .recordTransaction(
              order.id,
              successModel.idx,
            );
            await Future.delayed(const Duration(seconds: 3));
            Navigator.pop(context);
            await GeneralAlertDialog()
                .customAlertDialog(context, "Successfully bought");

            // // Perform Server Verification
            navigateAndRemoveAll(
                context,
                PaymentScreen(
                  price: price,
                  order: order,
                  productName: product.productName,
                ));
          } catch (ex) {
            Navigator.pop(context);
            GeneralAlertDialog().customAlertDialog(context, ex.toString());
          }
        },
        onFailure: (failureModel) {
          // What to do on failure?
          // log(failureModel.data.toString());
          GeneralAlertDialog().customAlertDialog(context, failureModel.message);
        },
        onCancel: () {
          // User manually cancelled the transaction
        },
      );
    }
  }

  makeConfig(
    int amount,
  ) {
    return PaymentConfig(
      amount: amount * 100, // Amount should be in paisa
      productIdentity: product.id.toString(),
      productName: product.productName,
      productUrl: 'https://www.khalti.com/#/bazaar',
      additionalData: {
        // Not mandatory; can be used for reporting purpose
        'vendor': 'Little Garden',
      },
    );
  }

  showPaymentBottomSheet(
    BuildContext context,
  ) async {
    return await showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                primary: Colors.green,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                "Cash on Delivery",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                "Pay with Khalti",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            // Center(
            //   child: KhaltiButton(
            //     config: config,
            //     preferences: const [
            //       PaymentPreference.khalti,
            //     ],
            //     onSuccess: (successModel) async {
            //       GeneralAlertDialog().customLoadingDialog(context);
            //       // await Provider.of<TicketProvider>(context, listen: false)
            //       //     .bookTicket(
            //       //         code: successModel.idx,
            //       //         ticketId: tempTicket.id,
            //       //         seatId: seatId);
            //       await Future.delayed(const Duration(seconds: 3));
            //       Navigator.pop(context);
            //       await GeneralAlertDialog()
            //           .customAlertDialog(context, "Successfully booked");

            //       // // Perform Server Verification
            //       navigateAndRemoveAll(
            //           context,
            //           PaymentScreen(
            //             order: order,
            //             price: price,
            //             productName: product.productName,
            //           ));
            //     },
            //     onFailure: (failureModel) {
            //       // What to do on failure?
            //       // log(failureModel.data.toString());
            //       GeneralAlertDialog()
            //           .customAlertDialog(context, failureModel.message);
            //     },
            //     onCancel: () {
            //       // User manually cancelled the transaction
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
