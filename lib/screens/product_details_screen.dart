import 'package:flower_shop/models/product.dart';
import 'package:flower_shop/providers/cart_provider.dart';
import 'package:flower_shop/providers/review_provider.dart';
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
    final future = Provider.of<ReviewProvider>(context, listen: false)
        .fetchReviews(product.id);
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
                return ListView.builder(
                  itemBuilder: ((context, index) => Card(
                          child: ListTile(
                        title: Text(data[index].comment),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_outlined,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(data[index].ratings.toString())
                          ],
                        ),
                      ))),
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
