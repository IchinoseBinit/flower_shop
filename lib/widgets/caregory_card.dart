import 'package:flower_shop/models/category.dart';
import 'package:flower_shop/screens/products_by_categories_screen.dart';
import 'package:flower_shop/utils/navigate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.category,
  }) : super(key: key);

  final double width, aspectRetio;
  final Category category;
  // final String category;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      child: GestureDetector(
        onTap: () => navigate(
          context,
          ProductsByCategoriesScreen(
            category: category,
          ),
        ),
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
                  tag: '${category.id.toString()} $category',
                  child: Image.network(
                    category.categoryImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              category.categoryName,
              // style: const TextStyle(color: Colors.black),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
