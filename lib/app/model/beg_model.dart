import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/app/model/product_model.dart';

/// id : "product id"
/// name : "product name"
/// brand : "product brand"
/// category : "product category"
/// measurement : "measurement"
/// quantity : 1
/// discount : 20
/// color : "Color"
/// size : "size"
/// added_at : {"__datatype__":"timestamp","value":{"_seconds":1626717600,"_nanoseconds":0}}

class BegModel {
  String? _id;
  String? _name;
  String? _brand;
  String? _category;
  String? _measurement;
  String? _image;
  int? _quantity;
  int? _discount;
  String? _color;
  String? _size;
  String? _price;
  // Added_at? _addedAt;

  String? get id => _id;
  String? get name => _name;
  String? get brand => _brand;
  String? get category => _category;
  String? get measurement => _measurement;
  String? get image => _image;
  int? get quantity => _quantity;
  int? get discount => _discount;
  String? get color => _color;
  String? get size => _size;
  String? get price => _price;
  set setPrice(String value) => _price = value;
  // Added_at? get addedAt => _addedAt;

  BegModel({
    String? id,
    String? name,
    String? brand,
    String? category,
    String? measurement,
    String? image,
    int? quantity,
    int? discount,
    String? color,
    String? size,
    String? price,
    // Added_at? addedAt
  }) {
    _id = id;
    _name = name;
    _brand = brand;
    _category = category;
    _measurement = measurement;
    _image = image;
    _quantity = quantity;
    _discount = discount;
    _color = color;
    _size = size;
    _price = price;
    // _addedAt = addedAt;
  }

  BegModel.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _brand = json["brand"];
    _category = json["category"];
    _measurement = json["measurement"];
    _image = json["image"];
    _quantity = json["quantity"];
    _discount = json["discount"];
    _color = json["color"];
    _size = json["size"];
    _price = json["price"];
    // _addedAt = json["added_at"] != null ? Added_at.fromJson(json["addedAt"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["brand"] = _brand;
    map["category"] = _category;
    map["measurement"] = _measurement;
    map["image"] = _image;
    map["quantity"] = _quantity;
    map["discount"] = _discount;
    map["color"] = _color;
    map["size"] = _size;
    map["price"] = _price;
    // if (_addedAt != null) {
    //   map["added_at"] = _addedAt?.toJson();
    // }
    return map;
  }

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
