import 'dart:convert';

List<Order> orderListFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.id,
    required this.date,
    required this.quantity,
    required this.status,
    required this.shippingTime,
    required this.userId,
    required this.product,
  });

  final int id;
  final DateTime date;
  final int quantity;
  final bool status;
  final DateTime shippingTime;
  final int userId;
  final int product;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        quantity: json["quantity"],
        status: json["status"],
        shippingTime: DateTime.parse(json["shipping_time"]),
        userId: json["user_id"],
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "quantity": quantity,
        "status": status,
        "shipping_time": shippingTime.toIso8601String(),
        "user_id": userId,
        "product": product,
      };
}
