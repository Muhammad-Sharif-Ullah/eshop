
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/app/model/product_model.dart';

class BegModel{

  static Map<String, dynamic> productToBeg(ProductModel product, String color, String size, int quantity){
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp currentTimeStamp = Timestamp.fromDate(currentPhoneDate);
    print(currentTimeStamp);
    final Map<String,dynamic> beg = {
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
    };
    return beg;
  }
}