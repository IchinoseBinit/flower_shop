// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'package:flower_shop/constants/urls.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.id,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.fullName,
    required this.dateJoined,
    required this.profileImage,
  });

  final int id;
  final String username;
  final String email;
  late String address;
  late String phone;
  late String fullName;
  final DateTime dateJoined;
  late String? profileImage;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"] ?? 0,
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        address: json["address"] ?? "",
        phone: json["phone_num"] ?? "",
        fullName: json["full_name"] ?? "",
        dateJoined: DateTime.parse(json["date_joined"]),
        profileImage: json["profile_image"] != null
            ? baseUrl + json["profile_image"]
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phone": phone,
        "full_name": fullName,
        "date_joined": dateJoined.toIso8601String(),
      };
}
