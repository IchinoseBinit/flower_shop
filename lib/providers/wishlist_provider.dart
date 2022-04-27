import 'package:flower_shop/models/product.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  List<Product> cart = [];

  addToCart(Product product) {
    if (!cart.contains(product)) {
      cart.add(product);
      notifyListeners();
    }
  }
}
