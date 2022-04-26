import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  Review({
    required this.id,
    required this.ratings,
    required this.comment,
    required this.productId,
    required this.userId,
  });

  final int id;
  final int ratings;
  final String comment;
  final int productId;
  final int userId;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        ratings: json["ratings"],
        comment: json["comment"],
        productId: json["product_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ratings": ratings,
        "comment": comment,
        "product_id": productId,
        "user_id": userId,
      };
}
