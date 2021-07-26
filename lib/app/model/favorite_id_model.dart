// To parse this JSON data, do
//
//     final favoritesIdModel = favoritesIdModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FavoritesIdModel favoritesIdModelFromJson(String str) => FavoritesIdModel.fromJson(json.decode(str));

String favoritesIdModelToJson(FavoritesIdModel data) => json.encode(data.toJson());

class FavoritesIdModel {
  FavoritesIdModel({
    @required this.productId,
  });

  final List<String>? productId;

  factory FavoritesIdModel.fromJson(Map<String, dynamic> json) => FavoritesIdModel(
    productId: List<String>.from(json["product_id"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "product_id": List<dynamic>.from(productId!.map((x) => x)),
  };
}
