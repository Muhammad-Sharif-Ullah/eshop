import 'package:eshop/app/components/cached_network_widget.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/model/beg_model.dart';
import 'package:eshop/app/modules/home/views/beg/views/components/bag_card_F.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BegCardM extends GetWidget<AccountServiceController> {
  const BegCardM({
    Key? key,
    required this.pID,
    required this.index,
    required this.beg,
  }) : super(key: key);
  final index;
  final String pID;
  final Rx<BegModel> beg;
  @override
  Widget build(BuildContext context) {
    Stream<double> priceAsStream(String prodId) {
      return controller.fireStore
          .collection('products')
          .doc(prodId)
          .snapshots()
          .map((items) {
        // print("${double.parse(items['old_price'])}");
        return double.parse(items['old_price']);
      });
    }

    Stream<int> quantityAsStream(String prodId) {
      return controller.fireStore
          .collection('products')
          .doc(prodId)
          .snapshots()
          .map((items) {
        // print("${items['quantity']}");
        return items['quantity'];
      });
    }

    Future<List<dynamic>> getBoth(String pID) async {
      final double d = await controller.fireStore
          .collection('products')
          .doc(pID)
          .get()
          .then((items) {
        return double.parse(items['old_price']);
      }).onError((FirebaseException error, stackTrace) {
        print(error.code);
        return 0.0;
      });
      final int q = await controller.fireStore
          .collection('products')
          .doc(pID)
          .get()
          .then((value) {
        return value.get('quantity');
      }).onError((FirebaseException error, stackTrace) {
        print(error.code);
        return 0;
      });
      return [q, d];
    }

    return Stack(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          color:
              Get.isDarkMode ? AppColors.blackDark : AppColors.backgroundLight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: CachedNetworkWidget(
                  width: 200,
                  height: 130,
                  url: controller.beg[index].image!,
                  // url: beg.value.image!,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      // controller.beg[index].name!,
                      beg.value.name!,
                      style: context.textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FutureBuilder<List<dynamic>>(
                        future: getBoth(controller.beg[index].id!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Text('Loading');
                          else if (snapshot.hasError)
                            return Text("${snapshot.error}");
                          return Text.rich(
                            TextSpan(
                                text: 'Color: ',
                                style: context.textTheme.bodyText1?.copyWith(
                                    color: Colors.grey, fontSize: 13),
                                children: [
                                  TextSpan(
                                    // text: controller.beg[index].color,
                                    text: snapshot.data![0].toString(),
                                    style: context.textTheme.bodyText1,
                                  ),
                                  TextSpan(
                                    style: context.textTheme.bodyText1
                                        ?.copyWith(color: Colors.grey),
                                    text: "  Size: ",
                                  ),
                                  TextSpan(
                                    style: context.textTheme.bodyText1,
                                    text: snapshot.data![1].toString(),
                                  ),
                                  // TextSpan(
                                  //   style: context.textTheme.caption
                                  //       ?.copyWith(color: Colors.grey),
                                  //   text: " ${controller.beg[index].id}",
                                  // ),
                                  // TextSpan(
                                  //   style: context.textTheme.caption
                                  //       ?.copyWith(color: Colors.grey),
                                  //   text: " $pID",
                                  // ),
                                ]),
                          );
                        }),
                    SizedBox(height: 10),
                    FutureBuilder<List<dynamic>>(
                        future: getBoth(controller.beg[index].id!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Text('Loading');
                          else if (snapshot.hasError)
                            return Text("${snapshot.error}");
                          else {
                            int originalProdQuantity = snapshot.data![0];
                            double originalProdPrice = snapshot.data![1];
                            RxInt vQuantity = RxInt(beg.value.quantity!);
                            RxDouble vPrice =
                                RxDouble(vQuantity.value * originalProdPrice);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FloatingActionButton(
                                      heroTag:
                                          "Remove ${controller.beg[index].id!}",
                                      onPressed: () async {
                                        print("OQ : $originalProdQuantity");
                                        print(controller.beg[index].quantity);

                                        if (beg.value.quantity! > 1) {
                                          vQuantity--;

                                          vPrice.value = originalProdPrice *
                                              vQuantity.value;
                                          await FireBaseCollection
                                              .changeQuantity(
                                                  vQuantity.value,
                                                  controller.beg[index].id!,
                                                  vPrice.toStringAsFixed(2));
                                          controller.getTotalPrice();
                                        }
                                      },
                                      child:
                                          Icon(Icons.remove, color: getColor()),
                                      mini: true,
                                    ),
                                    SizedBox(width: 10),
                                    Obx(() => Text(
                                        "${controller.beg[index].quantity}")),
                                    // Obx(() => Text("${vQuantity.value}")),
                                    // Obx(() => Text("${beg.value.quantity}")),
                                    SizedBox(width: 10),
                                    // ? INCREMENT
                                    FloatingActionButton(
                                        heroTag:
                                            "Add ${controller.beg[index].id!}",
                                        onPressed: () async {
                                          print("OQ : $originalProdQuantity");
                                          print(controller.beg[index].quantity);

                                          if (vQuantity.value <
                                              originalProdQuantity) {
                                            vQuantity++;
                                            print("Checking $vPrice");

                                            vPrice.value = originalProdPrice *
                                                vQuantity.value;
                                            print("Checking $vPrice");
                                            await FireBaseCollection
                                                .changeQuantity(
                                                    vQuantity.value,
                                                    controller.beg[index].id!,
                                                    vPrice.toStringAsFixed(2));
                                            controller.getTotalPrice();
                                          } else
                                            Get.rawSnackbar(
                                                message:
                                                    'You have reached max item',
                                                backgroundColor:
                                                    AppColors.error);
                                        },
                                        child:
                                            Icon(Icons.add, color: getColor()),
                                        mini: true),
                                  ],
                                ),
                                GetX(
                                  builder: (AccountServiceController cnt) {
                                    // vPrice.value = originalProdPrice.value *
                                    //     vQuantity.value;
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 14.0),
                                      child: Text(
                                        // '${vPrice.value.toPrecision(2)}\$',
                                        // '${controller.beg[index].price}\$',
                                        '${double.parse(controller.beg[index].price!).toStringAsFixed(2)}\$',
                                        style: context.textTheme.subtitle1
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: InkWell(
            child: Icon(Icons.close, color: Colors.red, size: 29),
            onTap: () {
              controller.total.value -=
                  double.parse(controller.beg[index].price!);
              // originalProdPrice.subject.close();
              // originalProdQuantity.subject.close();
              // controller.beg.remove(controller.beg[index]);
              controller.deleteItemFromBeg(beg.value.id!);
              // originalProdPrice.b
              Get.forceAppUpdate();
            },
          ),
        ),
      ],
    );
  }

  getColor() {
    return Get.isDarkMode ? Colors.white : Colors.black;
  }
}
