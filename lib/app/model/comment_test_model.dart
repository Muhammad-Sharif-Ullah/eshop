/// user_id : "user_Id"
/// user_name : "user_name"
/// product_Id : "product_id"
/// avatar : "user image url"
/// text : "comments"
/// images : ["images1","images2","images3"]
/// rate : 4
/// created_at : ""
/// reviewLiked : {"user_uid1":4,"user_uid2":4,"user_uid3":4,"user_uid4":4}

class CommentTestModel {
  String? _userId;
  String? _userName;
  String? _productId;
  String? _avatar;
  String? _text;
  List<String>? _images;
  int? _rate;
  String? _createdAt;
  ReviewLiked? _reviewLiked;

  String? get userId => _userId;
  String? get userName => _userName;
  String? get productId => _productId;
  String? get avatar => _avatar;
  String? get text => _text;
  List<String>? get images => _images;
  int? get rate => _rate;
  String? get createdAt => _createdAt;
  ReviewLiked? get reviewLiked => _reviewLiked;

  CommentTestModel({
      String? userId, 
      String? userName, 
      String? productId, 
      String? avatar, 
      String? text, 
      List<String>? images, 
      int? rate, 
      String? createdAt, 
      ReviewLiked? reviewLiked}){
    _userId = userId;
    _userName = userName;
    _productId = productId;
    _avatar = avatar;
    _text = text;
    _images = images;
    _rate = rate;
    _createdAt = createdAt;
    _reviewLiked = reviewLiked;
}

  CommentTestModel.fromJson(dynamic json) {
    _userId = json['user_id'];
    _userName = json['user_name'];
    _productId = json['product_Id'];
    _avatar = json['avatar'];
    _text = json['text'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _rate = json['rate'];
    _createdAt = json['created_at'];
    _reviewLiked = json['reviewLiked'] != null ? ReviewLiked.fromJson(json['reviewLiked']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['user_name'] = _userName;
    map['product_Id'] = _productId;
    map['avatar'] = _avatar;
    map['text'] = _text;
    map['images'] = _images;
    map['rate'] = _rate;
    map['created_at'] = _createdAt;
    if (_reviewLiked != null) {
      map['reviewLiked'] = _reviewLiked?.toJson();
    }
    return map;
  }

}

/// user_uid1 : 4
/// user_uid2 : 4
/// user_uid3 : 4
/// user_uid4 : 4

class ReviewLiked {
  int? _userUid1;
  int? _userUid2;
  int? _userUid3;
  int? _userUid4;

  int? get userUid1 => _userUid1;
  int? get userUid2 => _userUid2;
  int? get userUid3 => _userUid3;
  int? get userUid4 => _userUid4;

  ReviewLiked({
      int? userUid1, 
      int? userUid2, 
      int? userUid3, 
      int? userUid4}){
    _userUid1 = userUid1;
    _userUid2 = userUid2;
    _userUid3 = userUid3;
    _userUid4 = userUid4;
}

  ReviewLiked.fromJson(dynamic json) {
    _userUid1 = json['user_uid1'];
    _userUid2 = json['user_uid2'];
    _userUid3 = json['user_uid3'];
    _userUid4 = json['user_uid4'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['user_uid1'] = _userUid1;
    map['user_uid2'] = _userUid2;
    map['user_uid3'] = _userUid3;
    map['user_uid4'] = _userUid4;
    return map;
  }

}