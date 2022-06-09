import 'package:flower_shop/models/product.dart';
import 'package:flower_shop/providers/cart_provider.dart';
import 'package:flower_shop/providers/review_provider.dart';
import 'package:flower_shop/utils/show_toast.dart';
import 'package:flower_shop/widgets/curved_body_widget.dart';
import 'package:flower_shop/widgets/one_details_displayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  final Product product;

  // final

  @override
  Widget build(BuildContext context) {
    final future = Provider.of<ReviewProvider>(context, listen: false)
        .fetchReviews(product.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
      ),
      body: CurvedBodyWidget(
        widget: ListView(
          children: [
            Image.network(
              product.productImage,
              height: 200.h,
              width: double.infinity,
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
              child: const Text("Add to Cart"),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Reviews",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 8,
            ),
            FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = Provider.of<ReviewProvider>(context, listen: false)
                    .listOfReviews;
                return ListView.separated(
                  itemBuilder: ((context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Reviewed By: ${data[index].username}"),
                          ListTile(
                            title: Text(data[index].comment),
                            trailing: RatingBarIndicator(
                              rating: data[index].ratings.toDouble(),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                              direction: Axis.horizontal,
                            ),
                          ),
                        ],
                      )),
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                  ),
                  itemCount: data.length,
                  shrinkWrap: true,
                  primary: false,
                );
              },
            )
          ],
          shrinkWrap: true,
          primary: false,
        ),
      ),
    );
  }
}
