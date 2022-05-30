import 'package:flower_shop/models/product.dart';
import 'package:flower_shop/utils/custom_toast_animation.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 2000),
    ).then(
      (value) => Navigator.pop(context),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomAnimatedToast(
        productImage: widget.product.productImage,
      ),
    );
  }
}
