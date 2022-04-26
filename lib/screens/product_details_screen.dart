import 'package:flower_shop/models/product.dart';
import 'package:flower_shop/providers/cart_provider.dart';
import 'package:flower_shop/utils/show_toast.dart';
import 'package:flower_shop/widgets/curved_body_widget.dart';
import 'package:flower_shop/widgets/one_details_displayer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  final Product product;

  // final

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
      ),
      body: CurvedBodyWidget(
        widget: ListView(
          children: [
            Stack(
              children: [
                Image.network(
                  product.productImage,
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
            OneDetailDisplayer(
                title: "Product Name", value: product.productName),
            SizedBox(
              height: 8.h,
            ),
            OneDetailDisplayer(title: "Price", value: "Rs. ${product.price}"),
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
            Text(
              product.description,
            ),
            SizedBox(
              height: 24.h,
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .addToCart(product);
                showToast("Sucessfully added to cart");
              },
              child: Text("Add to Cart"),
            )
          ],
          shrinkWrap: true,
          primary: false,
        ),
      ),
    );
  }
}
