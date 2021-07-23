// /// id : "6067Ez9StdEJfQ3GN0qw"
// /// created_at : {"__datatype__":"timestamp","value":{"_seconds":1626717600,"_nanoseconds":0}}
// /// new_price : "52"
// /// colors : ["Black"]
// /// price_type : 1
// /// quantity : 2
// /// brand : "Terry Rayon"
// /// sizes : ["38","40","46","48"]
// /// measurement : ""
// /// name : "Jodhpuri Blazer"
// /// discount : 10
// /// images : ["products/6067Ez9StdEJfQ3GN0qw__1.jpg","products/6067Ez9StdEJfQ3GN0qw__2.jpg","products/6067Ez9StdEJfQ3GN0qw__3.jpg","products/6067Ez9StdEJfQ3GN0qw__4.jpg"]
// /// category : "Blazer"
// /// rating : [4,5]
// /// old_price : "62"
// /// description : "Classic look with this solid black color terry rayon fabric party wear jodhpuri blazer for mens. It has stand collar, full sleeves, welt pocket with pocket, full buttoned closure."
// /// last_update : {"__datatype__":"timestamp","value":{"_seconds":1626717600,"_nanoseconds":0}}
// /// gender : 1
//
// class Test {
//   String? _id;
//   Created_at? _createdAt;
//   String? _newPrice;
//   List<String>? _colors;
//   int? _priceType;
//   int? _quantity;
//   String? _brand;
//   List<String>? _sizes;
//   String? _measurement;
//   String? _name;
//   int? _discount;
//   List<String>? _images;
//   String? _category;
//   List<int>? _rating;
//   String? _oldPrice;
//   String? _description;
//   Last_update? _lastUpdate;
//   int? _gender;
//
//   String? get id => _id;
//   Created_at? get createdAt => _createdAt;
//   String? get newPrice => _newPrice;
//   List<String>? get colors => _colors;
//   int? get priceType => _priceType;
//   int? get quantity => _quantity;
//   String? get brand => _brand;
//   List<String>? get sizes => _sizes;
//   String? get measurement => _measurement;
//   String? get name => _name;
//   int? get discount => _discount;
//   List<String>? get images => _images;
//   String? get category => _category;
//   List<int>? get rating => _rating;
//   String? get oldPrice => _oldPrice;
//   String? get description => _description;
//   Last_update? get lastUpdate => _lastUpdate;
//   int? get gender => _gender;
//
//   Test({
//       String? id,
//       Created_at? createdAt,
//       String? newPrice,
//       List<String>? colors,
//       int? priceType,
//       int? quantity,
//       String? brand,
//       List<String>? sizes,
//       String? measurement,
//       String? name,
//       int? discount,
//       List<String>? images,
//       String? category,
//       List<int>? rating,
//       String? oldPrice,
//       String? description,
//       Last_update? lastUpdate,
//       int? gender}){
//     _id = id;
//     _createdAt = createdAt;
//     _newPrice = newPrice;
//     _colors = colors;
//     _priceType = priceType;
//     _quantity = quantity;
//     _brand = brand;
//     _sizes = sizes;
//     _measurement = measurement;
//     _name = name;
//     _discount = discount;
//     _images = images;
//     _category = category;
//     _rating = rating;
//     _oldPrice = oldPrice;
//     _description = description;
//     _lastUpdate = lastUpdate;
//     _gender = gender;
// }
//
//   Test.fromJson(dynamic json) {
//     _id = json["id"];
//     _createdAt = json["created_at"] != null ? Created_at.fromJson(json["createdAt"]) : null;
//     _newPrice = json["new_price"];
//     _colors = json["colors"] != null ? json["colors"].cast<String>() : [];
//     _priceType = json["price_type"];
//     _quantity = json["quantity"];
//     _brand = json["brand"];
//     _sizes = json["sizes"] != null ? json["sizes"].cast<String>() : [];
//     _measurement = json["measurement"];
//     _name = json["name"];
//     _discount = json["discount"];
//     _images = json["images"] != null ? json["images"].cast<String>() : [];
//     _category = json["category"];
//     _rating = json["rating"] != null ? json["rating"].cast<int>() : [];
//     _oldPrice = json["old_price"];
//     _description = json["description"];
//     _lastUpdate = json["last_update"] != null ? Last_update.fromJson(json["lastUpdate"]) : null;
//     _gender = json["gender"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     if (_createdAt != null) {
//       map["created_at"] = _createdAt?.toJson();
//     }
//     map["new_price"] = _newPrice;
//     map["colors"] = _colors;
//     map["price_type"] = _priceType;
//     map["quantity"] = _quantity;
//     map["brand"] = _brand;
//     map["sizes"] = _sizes;
//     map["measurement"] = _measurement;
//     map["name"] = _name;
//     map["discount"] = _discount;
//     map["images"] = _images;
//     map["category"] = _category;
//     map["rating"] = _rating;
//     map["old_price"] = _oldPrice;
//     map["description"] = _description;
//     if (_lastUpdate != null) {
//       map["last_update"] = _lastUpdate?.toJson();
//     }
//     map["gender"] = _gender;
//     return map;
//   }
//
// }
//
// /// __datatype__ : "timestamp"
// /// value : {"_seconds":1626717600,"_nanoseconds":0}
//
// class Last_update {
//   String? _datatype;
//   Value? _value;
//
//   String? get datatype => _datatype;
//   Value? get value => _value;
//
//   Last_update({
//       String? datatype,
//       Value? value}){
//     _datatype = datatype;
//     _value = value;
// }
//
//   Last_update.fromJson(dynamic json) {
//     _datatype = json["__datatype__"];
//     _value = json["value"] != null ? Value.fromJson(json["value"]) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["__datatype__"] = _datatype;
//     if (_value != null) {
//       map["value"] = _value?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// _seconds : 1626717600
// /// _nanoseconds : 0
//
// class Value {
//   int? _seconds;
//   int? _nanoseconds;
//
//   int? get seconds => _seconds;
//   int? get nanoseconds => _nanoseconds;
//
//   Value({
//       int? seconds,
//       int? nanoseconds}){
//     _seconds = seconds;
//     _nanoseconds = nanoseconds;
// }
//
//   Value.fromJson(dynamic json) {
//     _seconds = json["_seconds"];
//     _nanoseconds = json["_nanoseconds"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["_seconds"] = _seconds;
//     map["_nanoseconds"] = _nanoseconds;
//     return map;
//   }
//
// }
//
// /// __datatype__ : "timestamp"
// /// value : {"_seconds":1626717600,"_nanoseconds":0}
//
// class Created_at {
//   String? _datatype;
//   Value? _value;
//
//   String? get datatype => _datatype;
//   Value? get value => _value;
//
//   Created_at({
//       String? datatype,
//       Value? value}){
//     _datatype = datatype;
//     _value = value;
// }
//
//   Created_at.fromJson(dynamic json) {
//     _datatype = json["__datatype__"];
//     _value = json["value"] != null ? Value.fromJson(json["value"]) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["__datatype__"] = _datatype;
//     if (_value != null) {
//       map["value"] = _value?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// _seconds : 1626717600
// /// _nanoseconds : 0
//
// class Value {
//   int? _seconds;
//   int? _nanoseconds;
//
//   int? get seconds => _seconds;
//   int? get nanoseconds => _nanoseconds;
//
//   Value({
//       int? seconds,
//       int? nanoseconds}){
//     _seconds = seconds;
//     _nanoseconds = nanoseconds;
// }
//
//   Value.fromJson(dynamic json) {
//     _seconds = json["_seconds"];
//     _nanoseconds = json["_nanoseconds"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["_seconds"] = _seconds;
//     map["_nanoseconds"] = _nanoseconds;
//     return map;
//   }
//
// }