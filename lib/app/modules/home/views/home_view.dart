import 'package:eshop/app/components/customBottomNavigator.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> willExit() async {
      return await Get.defaultDialog(
        title: "Exit From Eshop",
        middleText: "Do you want to exit from E-shop",
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No',
                style: TextStyle(
                    color: context.isDarkMode ? Colors.white : Colors.black))),
        confirm: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes')),
        backgroundColor:
            context.isDarkMode ? AppColors.backgroundDark : Colors.white,
      );
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: willExit,
        child: Obx(() => controller.currentBody),
      ),
      bottomNavigationBar: CustomBottomNavigator(index: controller.getPageID()),
    );
  }
}


// https://www.fluttercampus.com/guide/46/how-to-override-back-button-and-show-exit-confirm-in-flutter-app/