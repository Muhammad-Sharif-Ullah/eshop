import 'package:eshop/app/components/bigSplashButton.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/model/delivery_model.dart';
import 'package:eshop/app/model/shipping_model.dart';
import 'package:eshop/app/modules/home/views/beg/views/payment_view.dart';
import 'package:eshop/app/modules/home/views/beg/views/success_payment_view.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'shipping_view.dart';

class CheckoutView extends GetWidget<AccountServiceController> {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxDouble methodPrice = 0.0.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._shippingAddress(context),
              SizedBox(height: 10),
              ..._paymentCard(context),
              SizedBox(height: 10),
              ..._deliveryMethod(context, methodPrice),
              SizedBox(height: 90),
              _amountSummery(context),
              SizedBox(height: 10),
              BigSplashButton(
                  height: 48,
                  width: context.width,
                  text: "SUBMIT ORDER",
                  onPressed: () => Get.to(() => SuccessPaymentView())),
            ],
          ),
        ),
      ),
    );
  }

  _shippingAddress(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Shopping Address",
            style: context.textTheme.subtitle1,
          ),
          GetX<AccountServiceController>(
            init: AccountServiceController(),
            builder: (cnt) {
              return InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    cnt.shippingAddress.any((element) => element.isActive)
                        ? "Change"
                        : "Add",
                    style: context.textTheme.caption?.copyWith(
                      color: AppColors.sell,
                      wordSpacing: -5,
                      fontSize: 15,
                    ),
                  ),
                ),
                onTap: () => Get.to(() => ShippingView()),
              );
            },
          ),
        ],
      ),
      SizedBox(height: 10),
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        color: Get.isDarkMode ? AppColors.blackDark : AppColors.backgroundLight,
        child: GetX<AccountServiceController>(
          init: AccountServiceController(),
          initState: (cnt) {},
          builder: (cnt) {
            if (cnt.shippingAddress.every((element) => !element.isActive))
              return Container(
                width: context.width,
                child: Text("Please add your shipping addres"),
                padding: const EdgeInsets.all(AppConstant.kPadding + 5),
              );
            final int activeIndex =
                cnt.shippingAddress.indexWhere((element) => element.isActive);
            final activeAddress = cnt.shippingAddress[activeIndex];
            return Container(
              padding: const EdgeInsets.all(AppConstant.kPadding + 5),
              width: context.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activeAddress.name),
                  Text(activeAddress.address),
                  Text(
                      "City: ${activeAddress.city}, Zip-Code: ${activeAddress.zip}"),
                ],
              ),
            );
          },
        ),
      ),
    ];
  }

  _paymentCard(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Payment",
            style: context.textTheme.subtitle1,
          ),
          TextButton(
              onPressed: () => Get.to(() => PaymentView()),
              child: Text("Change")),
        ],
      ),
      Container(
        width: context.width,
        padding: const EdgeInsets.all(AppConstant.kPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FlutterLogo(size: 50),
            SizedBox(width: 10),
            Text("***********5345"),
          ],
        ),
      ),
    ];
  }

  _deliveryMethod(BuildContext context, RxDouble methodPrice) {
    return [
      Text(
        "Delivery Method",
        style: context.textTheme.subtitle1,
      ),
      SizedBox(height: 14),
      SizedBox(
        height: 100,
        child: StreamBuilder<List<DeliveryModel>>(
            stream: controller.getDeliveryMethodAsSteam(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: Text("Loading"));
              else if (snapshot.hasError)
                return Text(snapshot.error.toString());

              final dMedthods = snapshot.data!;
              methodPrice.value = double.parse(dMedthods[0].deliveryCharge!);
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: dMedthods.length,
                  itemBuilder: (context, index) {
                    final DeliveryModel method = dMedthods[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        color: AppColors.backgroundLight,
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 17,
                                width: 61,
                                child: Image.network(
                                  method.image!,
                                  height: 17,
                                  width: 61,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Container(
                                      height: 10,
                                      width: 10,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: CupertinoActivityIndicator(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                method.deliveryTime!,
                                style: context.textTheme.caption
                                    ?.copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }),
      )
    ];
  }

  _amountSummery(BuildContext context) {
    return Column(
      children: [
        TotoalTextWidget(text: "Order:", value: ""),
        TotoalTextWidget(text: "Delivery:", value: "123"),
        TotoalTextWidget(text: "Summary:", value: "123"),
      ],
    );
  }
}

class TotoalTextWidget extends StatelessWidget {
  const TotoalTextWidget({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: context.textTheme.caption
                ?.copyWith(color: AppColors.grey, fontSize: 16),
          ),
          Text(
            '$value\$',
            style: context.textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
