import 'package:flower_shop/api/api_call.dart';
import 'package:flower_shop/constants/urls.dart';
import 'package:flower_shop/models/order.dart';
import 'package:flower_shop/models/product.dart';
import 'package:flower_shop/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  List<Product> cart = [];

  addToCart(Product product) {
    if (!cart.contains(product)) {
      cart.add(product);
      notifyListeners();
    }
  }

  updateQuantity(int id, {bool isAdded = true}) {
    if (isAdded) {
      getProductById(id).selectedQuantity += 1;
    } else {
      if (getProductById(id).selectedQuantity > 0) {
        getProductById(id).selectedQuantity -= 1;
      }
    }
    notifyListeners();
  }

  Product getProductById(int id) {
    return cart.firstWhere((element) => element.id == id);
  }

  Future<Order> postOrder(BuildContext context, int productId,
      {bool isCashOnDelivery = true}) async {
    try {
      final id =
          Provider.of<LoginProvider>(context, listen: false).user!.user.id;
      final product = getProductById(productId);
      final map = {
        "user_id": id,
        "date": DateFormat("yyy-MM-dd").format(DateTime.now()),
        "quantity": product.selectedQuantity,
        "status": true,
        "total_amount": product.selectedQuantity * product.price,
        "product": product.id,
        "payment_id": isCashOnDelivery ? 2 : 1,
      };

      return orderFromJson(
          await APICall().postRequestWithoutToken("$orderListUrl$id", map));
    } catch (ex) {
      rethrow;
    }
  }
}
