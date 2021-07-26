import 'package:eshop/app/components/futureImageWidget.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/model/beg_model.dart';
import 'package:eshop/app/values/appColors.dart';
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
  RxDouble price = 0.0.obs;
  RxInt quantity = 1.obs;
  RxInt vQuantity = 0.obs;
  RxDouble vPrice = 0.0.obs;
  late String prodId;
  final AccountServiceController controller = Get.find();

  @override
  void initState() {
    prodId = widget.beg.id!;
    price.bindStream(priceAsStream(prodId));
    quantity.bindStream(quantityAsStream(prodId));
    vQuantity.value = quantity.value;

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
                child: FutureImageWidget(
                  height: 130,
                  url: widget.beg.image!,
                  width: 200,
                ),
              ),
              // Image.asset(
              //   "assets/images/all_images/bag1.png",
              //   height: 130,
              //   fit: BoxFit.cover,
              //   filterQuality: FilterQuality.high,
              // )
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
                    Text.rich(
                      TextSpan(
                          text: 'Color: ',
                          style: context.textTheme.bodyText1
                              ?.copyWith(color: Colors.grey, fontSize: 13),
                          children: [
                            TextSpan(
                              text: widget.beg.color,
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
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                if (vQuantity.value > 1) {
                                  vQuantity.value--;
                                  // controller.beg[widget.index].setPrice = "${vQuantity.value * price.value}";
                                  // controller.getTotalPrice();
                                  controller.total.value -= (price.value * vQuantity.value);
                                }
                              },
                              child: Icon(Icons.remove, color: getColor()),
                              mini: true,
                            ),
                            SizedBox(width: 10),
                            Obx(() => Text("${vQuantity.value}")),
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
                                onPressed: () {
                                  if (vQuantity.value < quantity.value) {
                                    vQuantity.value++;
                                    // controller.beg[widget.index].setPrice = "${vQuantity.value * price.value}";
                                    // controller.getTotalPrice();
                                    controller.total.value += (price.value * (vQuantity.value-1));
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
                            vPrice.value = price.value * vQuantity.value;
                            return Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: Text(
                                '${vPrice.value.toPrecision(2)}\$',
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
            onTap: () {
              controller.total.value -= vPrice.value;
              return controller.deleteItemFromBeg(widget.beg.id!);
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
