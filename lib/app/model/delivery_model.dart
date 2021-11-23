// To parse this JSON data, do
//
//     final deliveryModel = deliveryModelFromJson(jsonString);

import 'dart:convert';

DeliveryModel deliveryModelFromJson(String str) =>
    DeliveryModel.fromJson(json.decode(str));

String deliveryModelToJson(DeliveryModel data) => json.encode(data.toJson());

class DeliveryModel {
  DeliveryModel({
    required this.method,
    required this.deliveryTime,
    required this.deliveryCharge,
    required this.image,
  });

  final String? method;
  final String? deliveryTime;
  final String? deliveryCharge;
  final String? image;

  factory DeliveryModel.fromJson(Map<String, dynamic> json) => DeliveryModel(
        method: json["method"],
        deliveryTime: json["delivery_time"],
        deliveryCharge: json["delivery_charge"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "method": method,
        "delivery_time": deliveryTime,
        "delivery_charge": deliveryCharge,
        "image": image,
      };
}
