import 'package:eshop/app/components/cached_network_widget.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/model/beg_model.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BegCard extends StatefulWidget {
  const BegCard({
    Key? key,
    required this.beg,
    required this.index,
  }) : super(key: key);

  final BegModel beg;
  final index;

  @override
  _BegCardState createState() => _BegCardState();
}

class _BegCardState extends State<BegCard> {
  RxDouble originalProdPrice = 0.0.obs;
  RxInt originalProdQuantity = 1.obs;
  RxInt vQuantity = 1.obs;
  RxDouble vPrice = 0.0.obs;
  late String prodId;
  final AccountServiceController controller = Get.find();

  @override
  void initState() {
    prodId = widget.beg.id!;
    originalProdPrice.bindStream(priceAsStream(prodId));
    originalProdQuantity.bindStream(quantityAsStream(prodId));
    vQuantity.value = widget.beg.quantity!;

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
                  url: widget.beg.image!,
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
                      widget.beg.name!,
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
                                  // text: widget.beg.color,
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
                                  text: widget.beg.size,
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
                              heroTag: "Remove $prodId",
                              onPressed: () async {
                                print(widget.beg.name);
                                if (vQuantity.value > 1) {
                                  vQuantity.value--;
                                  vPrice.value =
                                      originalProdPrice.value * vQuantity.value;
                                  await FireBaseCollection.changeQuantity(
                                      vQuantity.value,
                                      prodId,
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
                            // StreamBuilder<int>(
                            //     stream: quantityAsStream(prodId),
                            //     builder: (context, snapshot) {
                            //       if (snapshot.hasData) {
                            //         print(snapshot.data);
                            //         return Text("${snapshot.data}");
                            //       } else if (snapshot.error != null)
                            //         print(snapshot.error);
                            //       return Text('EMPTY');
                            //     }),
                            SizedBox(width: 10),
                            FloatingActionButton(
                                heroTag: "Add $prodId",
                                onPressed: () async {
                                  print(widget.beg.name);
                                  print(originalProdQuantity.value);
                                  if (vQuantity.value <
                                      originalProdQuantity.value) {
                                    vQuantity.value++;
                                    vPrice.value = originalProdPrice.value *
                                        vQuantity.value;
                                    await FireBaseCollection.changeQuantity(
                                        vQuantity.value,
                                        prodId,
                                        "${vPrice.value}");
                                    // widget.beg.setPrice(); setPrice(vPrice.value.toString());
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
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 14.0),
                        //   child: Obx(() {
                        //     controller.totalAmountAR[widget.index] = price.value * vQuantity.value;
                        //     // controller.totalAmountAR.add(price.value * vQuantity.value);
                        //     return Text(
                        //       '${price.value * vQuantity.value}\$',
                        //       style: context.textTheme.subtitle1
                        //           ?.copyWith(fontWeight: FontWeight.w600));
                        //   }),
                        // ),
                        GetX(
                          builder: (AccountServiceController cnt) {
                            vPrice.value =
                                originalProdPrice.value * vQuantity.value;
                            return Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: Text(
                                // '${vPrice.value.toPrecision(2)}\$',
                                // '${controller.beg[widget.index].price}\$',
                                '${widget.beg.price}\$',
                                style: context.textTheme.subtitle1
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                        ),
                        // StreamBuilder<double>(
                        //     stream: priceAsStream(prodId),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasData) {
                        //         print(snapshot.data);
                        //         return Text("${snapshot.data}");
                        //       } else if (snapshot.error != null)
                        //         print(snapshot.error);
                        //       return Text('EMPTY');
                        //     }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 8,
          top: 6,
          child: InkWell(
            child: Icon(Icons.close, color: Colors.red),
            onTap: () async {
              controller.total.value -=
                  double.parse(controller.beg[widget.index].price!);
              await controller.deleteItemFromBeg(widget.beg.id!);
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

  Stream<double> priceAsStream(String prodId) {
    return controller.fireStore
        .collection('products')
        .doc(prodId)
        .snapshots()
        .map((items) {
      return double.parse(items['old_price']);
    });
  }

  Stream<int> quantityAsStream(String prodId) {
    return controller.fireStore
        .collection('products')
        .doc(prodId)
        .snapshots()
        .map((items) {
      return items['quantity'];
    });
  }
}
