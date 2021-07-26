/// id : "product id"
/// name : "product name"
/// brand : "product brand"
/// category : "product category"
/// measurement : "measurement"
/// image : "image url"
/// quantity : 1
/// discount : 20
/// color : "Color"
/// size : "size"
/// added_at : {"__datatype__":"timestamp","value":{"_seconds":1626717600,"_nanoseconds":0}}

class Test {
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
  Added_at? _addedAt;

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
  Added_at? get addedAt => _addedAt;

  Test({
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
      Added_at? addedAt}){
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
    _addedAt = addedAt;
}

  Test.fromJson(dynamic json) {
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
    _addedAt = json["added_at"] != null ? Added_at.fromJson(json["addedAt"]) : null;
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
    if (_addedAt != null) {
      map["added_at"] = _addedAt?.toJson();
    }
    return map;
  }

}

/// __datatype__ : "timestamp"
/// value : {"_seconds":1626717600,"_nanoseconds":0}

class Added_at {
  String? _datatype;
  Value? _value;

  String? get datatype => _datatype;
  Value? get value => _value;

  Added_at({
      String? datatype, 
      Value? value}){
    _datatype = datatype;
    _value = value;
}

  Added_at.fromJson(dynamic json) {
    _datatype = json["__datatype__"];
    _value = json["value"] != null ? Value.fromJson(json["value"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["__datatype__"] = _datatype;
    if (_value != null) {
      map["value"] = _value?.toJson();
    }
    return map;
  }

}

/// _seconds : 1626717600
/// _nanoseconds : 0

class Value {
  int? _seconds;
  int? _nanoseconds;

  int? get seconds => _seconds;
  int? get nanoseconds => _nanoseconds;

  Value({
      int? seconds, 
      int? nanoseconds}){
    _seconds = seconds;
    _nanoseconds = nanoseconds;
}

  Value.fromJson(dynamic json) {
    _seconds = json["_seconds"];
    _nanoseconds = json["_nanoseconds"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_seconds"] = _seconds;
    map["_nanoseconds"] = _nanoseconds;
    return map;
  }

}