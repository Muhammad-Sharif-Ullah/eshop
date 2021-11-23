// To parse this JSON data, do
//
//     final shippingModel = shippingModelFromJson(jsonString);

// DateTime currentPhoneDate = DateTime.now(); //DateTime
// Timestamp currentTimeStamp = Timestamp.fromDate(currentPhoneDate);

import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

ShippingModel shippingModelFromJson(String str) =>
    ShippingModel.fromJson(json.decode(str));

String shippingModelToJson(ShippingModel data) => json.encode(data.toJson());

class ShippingModel {
  ShippingModel({
    required this.name,
    required this.address,
    required this.city,
    required this.zip,
    required this.isActive,
    required this.id,
  });

  String name;
  String address;
  String city;
  String zip;
  bool isActive;
  String id;

  factory ShippingModel.fromJson(Map<String, dynamic> json) => ShippingModel(
        name: json["name"],
        address: json["address"],
        city: json["city"],
        zip: json["zip"],
        isActive: json["is_active"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "city": city,
        "zip": zip,
        "is_active": isActive,
        "id": id,
      };
  static Map<String, dynamic> toModel(
      String name, String address, String city, String zip, bool isActive) {
    DateTime time = DateTime.now(); //DateTime
    return {
      "id": time
          .toIso8601String()
          .replaceAll("-", "")
          .replaceAll(":", "")
          .replaceAll(".", ""),
      "name": name,
      "address": address,
      "city": city,
      "zip": zip,
      "is_active": isActive,
    };
  }
}
