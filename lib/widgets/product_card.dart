import 'package:flower_shop/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    this.category = "todays deals",
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final String category;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      child: GestureDetector(
        onTap: () {},
        // => navigate(
        //   context,
        //   ProductDetailsScreen(product: product),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                padding: EdgeInsets.all(
                  6.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Hero(
                  tag: '${product.id.toString()} $category',
                  child: Image.network(
                    product.productImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.productName,
              // style: const TextStyle(color: Colors.black),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
