import 'package:eshop/app/components/cached_network_widget.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/model/beg_model.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Stream<double> priceAsStream(
    String prodId, AccountServiceController controller) {
  return controller.fireStore
      .collection('products')
      .doc(prodId)
      .snapshots()
      .map((items) {
    return double.parse(items['old_price']);
  });
}

Stream<int> quantityAsStream(
    String prodId, AccountServiceController controller) {
  return controller.fireStore
      .collection('products')
      .doc(prodId)
      .snapshots()
      .map((items) {
    return items['quantity'];
  });
}

class BegCardF extends GetWidget<AccountServiceController> {
  const BegCardF({Key? key, required this.index}) : super(key: key);
  // final Rx<BegModel> beg;
  final int index;
  @override
  Widget build(BuildContext context) {
    final beg = controller.beg[index];
    RxDouble originalProdPrice = RxDouble(0.0);
    RxInt originalProdQuantity = RxInt(0);
    originalProdPrice.bindStream(priceAsStream(beg.id!, controller));
    originalProdQuantity.bindStream(quantityAsStream(beg.id!, controller));

    addItem() async {
      int q = beg.quantity!;
      double p = double.parse(beg.price!);
      if (q < originalProdQuantity.value) {
        q++;
        p = q * p;
        await FireBaseCollection.changeQuantity(q, beg.id!, "$p");
        Get.appUpdate();
      } else {
        Get.rawSnackbar(
            message: 'You have reached max item',
            backgroundColor: AppColors.error);
      }
    }

    removeItem() async {
      int q = beg.quantity!;
      double p = double.parse(beg.price!);
      if (beg.quantity! > 1) {
        q--;
        // beg.setPrice('');
        await FireBaseCollection.changeQuantity(q, beg.id!, "${q * p}");
      }
    }

    return WillPopScope(
      onWillPop: () async {
        originalProdQuantity.close();
        originalProdPrice.close();
        return true;
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        color: Get.isDarkMode ? AppColors.blackDark : AppColors.backgroundLight,
        child: SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Product Name : ${beg.name!}"),
              Obx(() => Text("Product Price: ${controller.beg[index].price}")),
              Obx(() =>
                  Text("Product Quantity: ${controller.beg[index].quantity!}")),
              GetX<AccountServiceController>(
                init: AccountServiceController(),
                initState: (_) {},
                builder: (_) {
                  return Text("DB Price : $originalProdPrice");
                },
              ),
              GetX<AccountServiceController>(
                init: AccountServiceController(),
                initState: (_) {},
                builder: (_) {
                  return Text("DB Quantity : $originalProdQuantity");
                },
              ),
              SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: () => addItem(), icon: Icon(Icons.add)),
                  IconButton(
                      onPressed: () => removeItem(), icon: Icon(Icons.remove)),
                  IconButton(
                      onPressed: () {
                        // originalProdPrice.close();
                        // originalProdQuantity.close();
                        return controller.deleteItemFromBeg(beg.id!);
                      },
                      icon: Icon(Icons.close)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
