import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/model/delivery_model.dart';
import 'package:eshop/app/modules/home/controllers/home_controller.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryView extends GetView<HomeController> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final String uid = controller.user.value!.uid;
    final AccountServiceController asCNT = Get.find<AccountServiceController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Category View'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          child: Text("Check"),
          onPressed: () {
            final data = asCNT.fireStore
                .collection('delivery_method')
                .snapshots()
                .map((event) => event.docs.map((e) {
                      final data = DeliveryModel.fromJson(e.data());
                      return data;
                    }).toList());
            print(data.first.then((value) => value.first.deliveryCharge));
          },
        ),
      ),
    );
  }
}
