import 'package:eshop/app/components/cached_network_widget.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BegCardT extends StatefulWidget {
  const BegCardT({
    Key? key,
    // required this.beg,\
    required this.pID,
    required this.index,
  }) : super(key: key);

  // final Rx<BegModel> beg;
  final index;
  final String pID;

  @override
  _BegCardTState createState() => _BegCardTState();
}

class _BegCardTState extends State<BegCardT> {
  final AccountServiceController controller = Get.find();
  // late String prodId;

  RxDouble originalProdPrice = 0.0.obs;
  RxInt originalProdQuantity = 1.obs;
  RxInt vQuantity = 1.obs;
  RxDouble vPrice = 0.0.obs;

  @override
  void initState() {
    // prodId = controller.beg[widget.index].id!;
    // originalProdPrice.bindStream(priceAsStream(prodId));
    // originalProdQuantity.bindStream(quantityAsStream(prodId));
    priceAsFuture();
    quantityAsFuture();
    vQuantity.value = controller.beg[widget.index].quantity!;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // originalProdPrice.subject.close();
    // originalProdQuantity.subject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  url: controller.beg[widget.index].image!,
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
                      controller.beg[widget.index].name!,
                      style: context.textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Obx(() => Text.rich(
                          TextSpan(
                              text: 'Color: ',
                              style: context.textTheme.bodyText1
                                  ?.copyWith(color: Colors.grey, fontSize: 13),
                              children: [
                                TextSpan(
                                  // text: controller.beg[widget.index].color,
                                  text: originalProdQuantity.value.toString(),
                                  style: context.textTheme.bodyText1,
                                ),
                                TextSpan(
                                  style: context.textTheme.bodyText1
                                      ?.copyWith(color: Colors.grey),
                                  text: "  Size: ",
                                ),
                                TextSpan(
                                  style: context.textTheme.bodyText1,
                                  text: controller.beg[widget.index].size,
                                ),
                              ]),
                        )),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FloatingActionButton(
                              heroTag:
                                  "Remove ${controller.beg[widget.index].id!}",
                              onPressed: () async {
                                print("OQ : ${originalProdQuantity.value}");
                                print("vQ : ${vQuantity.value}");
                                print(controller.beg[widget.index].quantity);
                                // originalProdPrice.subject.close();
                                // originalProdQuantity.subject.close();
                                if (vQuantity.value > 1) {
                                  vQuantity.value--;

                                  vPrice.value =
                                      originalProdPrice * vQuantity.value;
                                  await FireBaseCollection.changeQuantity(
                                      vQuantity.value,
                                      widget.pID,
                                      "${vPrice.value}");
                                  controller.getTotalPrice();
                                }
                              },
                              child: Icon(Icons.remove, color: getColor()),
                              mini: true,
                            ),
                            SizedBox(width: 10),
                            Obx(() => Text(
                                "${controller.beg[widget.index].quantity}")),
                            // Obx(() => Text("${vQuantity.value}")),
                            // Obx(() => Text("${beg.value.quantity}")),
                            SizedBox(width: 10),
                            FloatingActionButton(
                                heroTag:
                                    "Add ${controller.beg[widget.index].id!}",
                                onPressed: () async {
                                  print("OQ : ${originalProdQuantity.value}");
                                  print("vQ : ${vQuantity.value}");
                                  print(controller.beg[widget.index].quantity);
                                  // originalProdPrice.subject.close();
                                  // originalProdQuantity.subject.close();
                                  if (vQuantity.value <
                                      originalProdQuantity.value) {
                                    vQuantity.value++;
                                    vPrice.value = originalProdPrice.value *
                                        vQuantity.value;
                                    await FireBaseCollection.changeQuantity(
                                        vQuantity.value,
                                        widget.pID,
                                        "${vPrice.value}");
                                    controller.getTotalPrice();
                                  } else
                                    Get.rawSnackbar(
                                        message: 'You have reached max item',
                                        backgroundColor: AppColors.error);
                                },
                                child: Icon(Icons.add, color: getColor()),
                                mini: true),
                          ],
                        ),
                        GetX(
                          builder: (AccountServiceController cnt) {
                            vPrice.value =
                                originalProdPrice.value * vQuantity.value;
                            return Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: Text(
                                // '${vPrice.value.toPrecision(2)}\$',
                                // '${controller.beg[index].price}\$',
                                '${double.parse(controller.beg[widget.index].price!).toStringAsFixed(2)}\$',
                                style: context.textTheme.subtitle1
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
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
                  double.parse(controller.beg[widget.index].price!);
              // originalProdPrice.subject.close();
              // originalProdQuantity.subject.close();
              // controller.beg.remove(controller.beg[widget.index]);
              controller.deleteItemFromBeg(widget.pID);
              // originalProdPrice.b
              // Get.forceAppUpdate();
            },
          ),
        ),
      ],
    );
  }

  getColor() {
    return Get.isDarkMode ? Colors.white : Colors.black;
  }

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

  Future<void> priceAsFuture() async {
    await controller.fireStore
        .collection('products')
        .doc(widget.pID)
        .get()
        .then((items) {
      originalProdPrice = RxDouble(double.parse(items['old_price']));
      print('Chekcing price: $originalProdPrice.value');
    }).onError((FirebaseException error, stackTrace) {
      print(error.code);
    });
  }

  Future<void> quantityAsFuture() async {
    await controller.fireStore
        .collection('products')
        .doc(widget.pID)
        .get()
        .then((value) {
      originalProdQuantity = RxInt(value.get('quantity'));
      print('Chekcing quantity: $originalProdQuantity.value');
    }).onError((FirebaseException error, stackTrace) {
      print(error.code);
    });
  }
}
