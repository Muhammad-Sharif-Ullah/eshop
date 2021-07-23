// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.avatar,
  });

  final String name;
  final String email;
  final String uid;
  final String avatar;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    email: json["email"],
    uid: json["uid"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "uid": uid,
    "avatar": avatar,
  };
}
