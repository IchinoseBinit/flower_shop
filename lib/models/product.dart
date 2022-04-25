// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:flower_shop/constants/urls.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.description,
    required this.isRecentlyAdded,
    required this.isPopular,
    required this.categoryId,
  });

  final int id;
  final String productName;
  final String productImage;
  final String description;
  final bool isRecentlyAdded;
  final bool isPopular;
  final int categoryId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productName: json["product_name"],
        productImage: baseUrl + json["product_image"],
        description: json["description"],
        isRecentlyAdded: json["is_recently_added"],
        isPopular: json["is_popular"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "product_image": productImage,
        "description": description,
        "is_recently_added": isRecentlyAdded,
        "is_popular": isPopular,
        "category_id": categoryId,
      };
}
