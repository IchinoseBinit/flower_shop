import 'dart:developer';

import 'package:flower_shop/api/api_call.dart';
import 'package:flower_shop/constants/urls.dart';
import 'package:flower_shop/models/category.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> listOfcategories = [];

  fetchCategories() async {
    try {
      if (listOfcategories.isNotEmpty) return;
      final response = await APICall().getRequestWithToken(categoriesUrl);
      listOfcategories = categoryFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
}
