/// quantity : 55
/// images : ["https://firebasestorage.googleapis.com/v0/b/eshop-86482.appspot.com/o/products%2FsikY630IWX41iwH6viMK__1.jpg?alt=media&token=a0e25cbc-92f3-4f2b-a8d1-cca262550b8d","https://firebasestorage.googleapis.com/v0/b/eshop-86482.appspot.com/o/products%2FsikY630IWX41iwH6viMK__2.jpg?alt=media&token=c343454d-f3b8-45aa-9518-8c9a814d0f8f","https://firebasestorage.googleapis.com/v0/b/eshop-86482.appspot.com/o/products%2FsikY630IWX41iwH6viMK__3.jpg?alt=media&token=497985ff-1459-4b1b-9230-9327930e650a","https://firebasestorage.googleapis.com/v0/b/eshop-86482.appspot.com/o/products%2FsikY630IWX41iwH6viMK__4.jpg?alt=media&token=8c1e7816-182b-4d92-ab88-077320cea299","https://firebasestorage.googleapis.com/v0/b/eshop-86482.appspot.com/o/products%2FsikY630IWX41iwH6viMK__5.jpg?alt=media&token=2fb4494f-035a-44fe-a87c-4afb6068dc19"]
/// category : "Scarf"
/// colors : ["Blue","Navey Blue","Black","Print","White"]
/// TimeConvertion : {"__datatype__":"timestamp","value":{"_seconds":1626717600,"_nanoseconds":0}}
/// sizes : ["24","26","28","30"]
/// measurement : ""
/// name : "Shawl Cashmere"
/// discount : 5
/// TimeConvertion : {"__datatype__":"timestamp","value":{"_seconds":1626717600,"_nanoseconds":0}}
/// brand : "Shanghai"
/// old_price : 12
/// new_price : 10
/// id : "sikY630IWX41iwH6viMK"
/// price_type : 1
/// gender : 2
/// description : "Winter Scarf for Women Brand Designer Shawl Cashmere Plaid Scarves Blanket Wholesale"

class ProductModel {
  int? _quantity;
  List<String>? _images;
  String? _category;
  List<String>? _colors;
  TimeConversion? _createdAt;
  List<String>? _sizes;
  String? _measurement;
  Map<String, int>? _rating;
  String? _name;
  int? _discount;
  TimeConversion? _lastUpdate;
  String? _brand;
  String? _oldPrice;
  String? _newPrice;
  String? _id;
  int? _priceType;
  int? _gender;
  String? _description;

  int? get quantity => _quantity;

  List<String>? get images => _images;

  String? get category => _category;

  List<String>? get colors => _colors;

  TimeConversion? get createdAt => _createdAt;

  List<String>? get sizes => _sizes;

  String? get measurement => _measurement;

  Map<String, int>? get rating => _rating;

  String? get name => _name;

  int? get discount => _discount;

  TimeConversion? get lastUpdate => _lastUpdate;

  String? get brand => _brand;

  String? get oldPrice => _oldPrice;

  String? get newPrice => _newPrice;

  String? get id => _id;

  int? get priceType => _priceType;

  int? get gender => _gender;

  String? get description => _description;

  ProductModel(
      {int? quantity,
      List<String>? images,
      String? category,
      List<String>? colors,
      TimeConversion? createdAt,
      List<String>? sizes,
      Map<String, int>? rating,
      String? measurement,
      String? name,
      int? discount,
      TimeConversion? lastUpdate,
      String? brand,
      String? oldPrice,
      String? newPrice,
      String? id,
      int? priceType,
      int? gender,
      String? description}) {
    _quantity = quantity;
    _images = images;
    _category = category;
    _colors = colors;
    _createdAt = createdAt;
    _sizes = sizes;
    _measurement = measurement;
    _name = name;
    _discount = discount;
    _lastUpdate = lastUpdate;
    _brand = brand;
    _oldPrice = oldPrice;
    _newPrice = newPrice;
    _id = id;
    _priceType = priceType;
    _rating = rating;
    _gender = gender;
    _description = description;
  }

  ProductModel.fromJson(dynamic json) {
    _quantity = json["quantity"];
    _images = json["images"] != null ? json["images"].cast<String>() : [];
    _category = json["category"];
    _colors = json["colors"] != null ? json["colors"].cast<String>() : [];
    _createdAt = json["TimeConvertion"] != null
        ? TimeConversion.fromJson(json["createdAt"])
        : null;
    _sizes = json["sizes"] != null ? json["sizes"].cast<String>() : [];
    _measurement = json["measurement"];
    _name = json["name"];
    _discount = json["discount"];
    _rating = json["rating"] != null ? json["rating"].cast<String, int>() : <String,int>{};
    _lastUpdate = json["TimeConvertion"] != null
        ? TimeConversion.fromJson(json["lastUpdate"])
        : null;
    _brand = json["brand"];
    _oldPrice = json["old_price"];
    _newPrice = json["new_price"];
    _id = json["id"];
    _priceType = json["price_type"];
    _gender = json["gender"];
    _description = json["description"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["quantity"] = _quantity;
    map["images"] = _images;
    map["category"] = _category;
    map["rating"] = _rating;
    map["colors"] = _colors;
    if (_createdAt != null) {
      map["TimeConvertion"] = _createdAt?.toJson();
    }
    map["sizes"] = _sizes;
    map["measurement"] = _measurement;
    map["name"] = _name;
    map["discount"] = _discount;
    if (_lastUpdate != null) {
      map["TimeConvertion"] = _lastUpdate?.toJson();
    }
    map["brand"] = _brand;
    map["old_price"] = _oldPrice;
    map["new_price"] = _newPrice;
    map["id"] = _id;
    map["price_type"] = _priceType;
    map["gender"] = _gender;
    map["description"] = _description;
    return map;
  }
}

/// __datatype__ : "timestamp"
/// value : {"_seconds":1626717600,"_nanoseconds":0}

class TimeConversion {
  TimeStampFormat? _value;

  TimeStampFormat? get value => _value;

  TimeConversion({TimeStampFormat? value}) {
    _value = value;
  }

  TimeConversion.fromJson(dynamic json) {
    _value =
        json["value"] != null ? TimeStampFormat.fromJson(json["value"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_value != null) {
      map["value"] = _value?.toJson();
    }
    return map;
  }
}

/// _seconds : 1626717600
/// _nanoseconds : 0

class TimeStampFormat {
  int? _seconds;
  int? _nanoseconds;

  int? get seconds => _seconds;

  int? get nanoseconds => _nanoseconds;

  TimeStampFormat({int? seconds, int? nanoseconds}) {
    _seconds = seconds;
    _nanoseconds = nanoseconds;
  }

  TimeStampFormat.fromJson(dynamic json) {
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
