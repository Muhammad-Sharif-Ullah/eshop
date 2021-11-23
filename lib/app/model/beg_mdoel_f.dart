// To parse this JSON data, do
//
//     final begModel = begModelFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

BegModel_F begModelFromJson(String str) =>
    BegModel_F.fromJson(json.decode(str));

String begModelToJson(BegModel_F data) => json.encode(data.toJson());

class BegModel_F {
  BegModel_F({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.measurement,
    required this.image,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.color,
    required this.size,
    required this.addedAt,
  });

  String? id;
  String? name;
  String? brand;
  String? category;
  String? measurement;
  String? price;
  String? image;
  int? quantity;
  int? discount;
  String? color;
  String? size;
  AddedAt? addedAt;

  factory BegModel_F.fromJson(Map<String, dynamic> json) => BegModel_F(
        id: json["id"],
        name: json["name"],
        brand: json["brand"],
        category: json["category"],
        measurement: json["measurement"],
        image: json["image"],
        quantity: json["quantity"],
        discount: json["discount"],
        color: json["color"],
        size: json["size"],
        price: json['price'],
        addedAt: AddedAt.fromJson(json["added_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "brand": brand,
        "category": category,
        "measurement": measurement,
        "image": image,
        "quantity": quantity,
        "discount": discount,
        "color": color,
        "size": size,
        "added_at": addedAt!.toJson(),
      };
  static Map<String, dynamic> productToBeg(
      ProductModel product, String color, String size, int quantity) {
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp currentTimeStamp = Timestamp.fromDate(currentPhoneDate);
    print(currentTimeStamp);
    final Map<String, dynamic> beg = {
      "id": product.id,
      "name": product.name,
      "brand": product.brand,
      "category": product.category,
      "measurement": product.measurement,
      "color": color,
      "size": size,
      "discount": product.discount,
      "quantity": quantity,
      "added_at": currentTimeStamp,
      "image": product.images![0],
      "price": product.oldPrice, // TODO: Decide it later
    };
    return beg;
  }
}

class AddedAt {
  AddedAt({
    required this.datatype,
    required this.value,
  });

  String? datatype;
  TValue? value;

  factory AddedAt.fromJson(Map<String, dynamic> json) => AddedAt(
        datatype: json["__datatype__"],
        value: TValue.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "__datatype__": datatype,
        "value": value!.toJson(),
      };
}

class TValue {
  TValue({
    required this.seconds,
    required this.nanoseconds,
  });

  int? seconds;
  int? nanoseconds;

  factory TValue.fromJson(Map<String, dynamic> json) => TValue(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}
