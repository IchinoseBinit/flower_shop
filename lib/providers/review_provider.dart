import 'dart:developer';

import 'package:flower_shop/api/api_call.dart';
import 'package:flower_shop/constants/urls.dart';
import 'package:flower_shop/models/review.dart';
import 'package:flutter/material.dart';

class ReviewProvider extends ChangeNotifier {
  List<Review> listOfReviews = [];

  fetchReviews(int id) async {
    try {
      final response =
          await APICall().getRequestWithToken("$reviewProductsUrl/$id");
      listOfReviews = reviewFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  postReview({
    required int id,
    required Map map,
  }) async {
    try {
      final response = await APICall().postRequestWithToken(
        "$reviewProductsUrl/$id",
        map,
      );
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
}
