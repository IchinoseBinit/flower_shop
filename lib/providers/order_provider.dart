import 'dart:developer';

import 'package:flower_shop/api/api_call.dart';
import 'package:flower_shop/constants/urls.dart';
import 'package:flower_shop/models/category.dart';
import 'package:flower_shop/models/order.dart';
import 'package:flower_shop/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> listOfOrders = [];

  fetchOrders(BuildContext context) async {
    try {
      final id =
          Provider.of<LoginProvider>(context, listen: false).user!.user.id;
      final response = await APICall().getRequestWithToken("$orderListUrl$id");
      listOfOrders = orderListFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
}
