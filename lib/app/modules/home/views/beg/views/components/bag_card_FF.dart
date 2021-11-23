import 'package:eshop/app/components/cached_network_widget.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/model/beg_model.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BegCardFF extends StatefulWidget {
  const BegCardFF({
    Key? key,
    required this.beg,
    required this.index,
  }) : super(key: key);

  final Rx<BegModel> beg;
  final index;

  @override
  _BegCardFFState createState() => _BegCardFFState();
}

class _BegCardFFState extends State<BegCardFF> {
  RxDouble originalProdPrice = 0.0.obs;
  RxInt originalProdQuantity = 1.obs;
  RxInt vQuantity = 1.obs;
  RxDouble vPrice = 0.0.obs;
  // late String prodId;
  final AccountServiceController controller = Get.find();

  @override
  void initState() {
    // prodId = widget.beg.value.id!;
    priceAsFuture();
    quantityAsFuture();
    vQuantity.value = widget.beg.value.quantity!;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> priceAsFuture() async {
    await controller.fireStore
        .collection('products')
        .doc(controller.beg[widget.index].id!)
        .get()
        .then((items) {
      originalProdPrice = RxDouble(double.parse(items['old_price']));
      print('Chekcing price: $originalProdPrice.value');
    });
  }

  Future<void> quantityAsFuture() async {
    await controller.fireStore.collection('products').doc().get().then((value) {
      originalProdQuantity = RxInt(value.get('quantity'));
      print('Chekcing quantity: $originalProdQuantity.value');
    });
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
                  url: widget.beg.value.image!,
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
                      widget.beg.value.name!,
                      style: context.textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text.rich(
                      TextSpan(
                          text: 'Color: ',
                          style: context.textTheme.bodyText1
                              ?.copyWith(color: Colors.grey, fontSize: 13),
                          children: [
                            TextSpan(
                              text: widget.beg.value.color,
                              // text: originalProdQuantity.value.toString(),
                              style: context.textTheme.bodyText1,
                            ),
                            TextSpan(
                              style: context.textTheme.bodyText1
                                  ?.copyWith(color: Colors.grey),
                              text: "  Size: ",
                            ),
                            TextSpan(
                              style: context.textTheme.bodyText1,
                              text: widget.beg.value.size,
                            ),
                          ]),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FloatingActionButton(
                              heroTag: "Remove ${widget.beg.value.id!}",
                              onPressed: () async {
                                print(widget.beg.value.name);
                                if (vQuantity.value > 1) {
                                  vQuantity.value--;
                                  vPrice.value =
                                      originalProdPrice.value * vQuantity.value;
                                  await FireBaseCollection.changeQuantity(
                                      vQuantity.value,
                                      controller.beg[widget.index].id!,
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
                            // Obx(() => Text("${widget.beg.value.quantity}")),
                            SizedBox(width: 10),
                            FloatingActionButton(
                                heroTag: "Add ${widget.beg.value.id!}",
                                onPressed: () async {
                                  print("OQ : ${originalProdQuantity.value}");
                                  print("vQ : ${vQuantity.value}");
                                  print(controller.beg[widget.index].quantity);
                                  // print("${widget.beg.id!}");
                                  // vQuantity.value
                                  if (controller.beg[widget.index].quantity! <
                                      originalProdQuantity.value) {
                                    print("T");
                                    vQuantity.value++;
                                    vPrice.value = originalProdPrice.value *
                                        vQuantity.value;
                                    await FireBaseCollection.changeQuantity(
                                        vQuantity.value,
                                        controller.beg[widget.index].id!,
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
                                // '${controller.beg[widget.index].price}\$',
                                '${double.parse(widget.beg.value.price!).toStringAsFixed(2)}\$',
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
            onTap: () async {
              controller.total.value -=
                  double.parse(controller.beg[widget.index].price!);
              controller.beg.remove(widget.beg);

              return await controller.deleteItemFromBeg(widget.beg.value.id!);
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
