import 'package:flower_shop/models/order.dart';
import 'package:flower_shop/providers/product_provider.dart';
import 'package:flower_shop/providers/review_provider.dart';
import 'package:flower_shop/utils/navigate.dart';
import 'package:flower_shop/utils/validation_mixin.dart';
import 'package:flower_shop/widgets/general_alert_dialog.dart';
import 'package:flower_shop/widgets/general_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
    return GestureDetector(
      onTap: () async {
        final map = await bottomSheet(context);
        if (map != null) {
          final body = {
            "product_id": order.product,
            "user_id": order.userId,
            ...map,
          };
          GeneralAlertDialog().customLoadingDialog(context);
          await Provider.of<ReviewProvider>(context, listen: false)
              .postReview(id: order.product, map: body);
          Navigator.pop(context);
        }
      },
      child: Row(
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
      ),
    );
  }

  bottomSheet(BuildContext context) async {
    final commentController = TextEditingController();
    int productRating = 3;
    final formKey = GlobalKey<FormState>();
    return await showModalBottomSheet(
      context: context,
      builder: (_) => StatefulBuilder(builder: (context, set) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            24,
            16,
            MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GeneralTextField(
                    title: "Comment",
                    controller: commentController,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maxLength: 10,
                    validate: (value) =>
                        ValidationMixin().validate(value!, "Comment"),
                    onFieldSubmitted: (_) {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Rate the app"),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Color(0xFFD84315),
                    ),
                    onRatingUpdate: (rating) {
                      set(() {
                        productRating = rating.toInt();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final map = {
                          "ratings": productRating,
                          "comment": commentController.text
                        };
                        Navigator.pop(context, map);
                      }
                    },
                    child: const Text("Rate"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
