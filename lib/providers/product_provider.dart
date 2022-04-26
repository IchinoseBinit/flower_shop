import 'dart:developer';

import 'package:flower_shop/api/api_call.dart';
import 'package:flower_shop/constants/urls.dart';
import 'package:flower_shop/models/product.dart';
import 'package:flutter/cupertino.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> listOfProducts = [];
  List<Product> listOfLatestProducts = [];
  List<Product> listOfPopularProducts = [];
  List<Product> listOfProductsByCategory = [];

  fetchProducts() async {
    try {
      if (listOfProducts.isNotEmpty) return;
      final response = await APICall().getRequestWithToken(productsUrl);
      log(response);
      listOfProducts = productFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  fetchProductsByCategory(int id) async {
    try {
      final response = await APICall()
          .getRequestWithToken(categoriesProductsUrl + id.toString());
      log(response);
      listOfProductsByCategory = productFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  fetchLatestProducts() async {
    try {
      if (listOfLatestProducts.isNotEmpty) return;
      final response = await APICall().getRequestWithToken(latestProductsUrl);
      listOfLatestProducts = productFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  fetchPopularProducts() async {
    try {
      if (listOfPopularProducts.isNotEmpty) return;
      final response = await APICall().getRequestWithToken(popularProductsUrl);
      listOfPopularProducts = productFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  // updateQuantity(int id, int quantity) {
  //   getProductById(id).selectedQuantity = quantity;
  //   notifyListeners();
  // }

  Product getProductById(int id) {
    final list = [
      ...listOfLatestProducts,
      ...listOfPopularProducts,
      ...listOfProducts,
      ...listOfProductsByCategory
    ];
    return list.firstWhere((element) => element.id == id);
  }
}
