import 'package:eshop/app/components/bigSplashButton.dart';
import 'package:eshop/app/modules/home/bindings/home_binding.dart';
import 'package:eshop/app/modules/home/controllers/home_controller.dart';
import 'package:eshop/app/modules/home/views/home_view.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessPaymentView extends GetWidget {
  const SuccessPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeCNT = Get.find<HomeController>();
    return Scaffold(
      body: Container(
        width: context.width,
        padding: const EdgeInsets.all(AppConstant.kPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset("assets/images/success_image.png"),
            SizedBox(height: 20),
            Text(
              "Success!",
              style: context.textTheme.headline2,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: context.width * .8,
              child: Text(
                "Your order will be delivered soon.\nThank you for choosing our app!",
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            BigSplashButton(
              height: 48,
              width: context.width,
              text: "Continue Shopping",
              onPressed: () {
                homeCNT.pageIndex.value = 0;
                Get.back();
                Get.back();
                // Get.offAll(() => HomeView(), binding: HomeBinding());
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
