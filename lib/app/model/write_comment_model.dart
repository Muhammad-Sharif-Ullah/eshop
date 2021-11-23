import 'package:cloud_firestore/cloud_firestore.dart';

/// user_id : "user_Id"
/// user_name : "user_name"
/// product_Id : "product_id"
/// text : "comments"
/// avatar: User Image url
/// images : ["images1","images2","images3"]
/// rate : 4
/// created_at : ""
// DateTime currentPhoneDate = DateTime.now(); //DateTime
// Timestamp currentTimeStamp = Timestamp.fromDate(currentPhoneDate);
class WriteCommentModel {
  String? _userId;
  String? _userName;
  String? _productId;
  String? _avatar;
  String? _text;
  List<String>? _images;
  int? _rate;
  Timestamp? _createdAt;
  List<String>? _reviewLiked;


  String? get userId => _userId;
  String? get userName => _userName;
  String? get productId => _productId;
  String? get avatar => _avatar;
  String? get text => _text;
  List<String>? get images => _images;
  int? get rate => _rate;
  List<String>? get reviewLiked => _reviewLiked;
  Timestamp? get createdAt => _createdAt;

  WriteCommentModel({
      String? userId, 
      String? userName, 
      String? productId, 
      String? text,
      String? avatar,
      List<String>? images,
      int? rate,
    List<String>? reviewLiked,
    Timestamp? createdAt}){
    _userId = userId;
    _userName = userName;
    _productId = productId;
    _text = text;
    _images = images;
    _rate = rate;
    _reviewLiked = reviewLiked;
    _createdAt = createdAt;
    _avatar = avatar;
}

  WriteCommentModel.fromJson(dynamic json) {
    _userId = json["user_id"];
    _userName = json["user_name"];
    _productId = json["product_Id"];
    _text = json["text"];
    _images = json["images"] != null ? json["images"].cast<String>() : [];
    _rate = json["rate"];
    _reviewLiked = json["reviewLiked"] != null ? json["reviewLiked"].cast<String>() : [];
    _avatar = json['avatar'];
    _createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = _userId;
    map["user_name"] = _userName;
    map["product_Id"] = _productId;
    map["text"] = _text;
    map["images"] = _images;
    map["rate"] = _rate;
    map["reviewLiked"] = _reviewLiked;
    map["created_at"] = _createdAt;
    map['avatar'] = _avatar;
    return map;
  }

}