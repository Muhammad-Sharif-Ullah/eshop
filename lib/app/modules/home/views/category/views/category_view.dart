
import 'package:eshop/app/model/product_model.dart';
import 'package:eshop/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CategoryView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category View'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Fetch Data"),
          onPressed: () async {
            final data = await controller.fireStore.collection('products').get();
            final ProductModel product = ProductModel.fromJson(data.docs[0].data());
            print(product.createdAt);
            // print(data.docs[0].data());
            // List<UserModel> users = [];
            // await controller.fireStore
            //     .collection('users')
            //     .get()
            //     .then((QuerySnapshot<Map<String, dynamic>> value) {
            //   // UserModel users = UserModel.fromJson(value.docs.toList().data()) ;
            //   for(QueryDocumentSnapshot<Map<String, dynamic>> userData in value.docs)
            //     users.add(UserModel.fromJson(userData.data()));
            // });
            // print(users[0].email);
          },
        ),
      ),
    );
  }
}
