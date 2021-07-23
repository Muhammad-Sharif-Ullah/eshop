import 'package:eshop/app/components/customBottomNavigator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';


class HomeView extends GetWidget<HomeController> {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(()=>controller.currentBody),
      bottomNavigationBar: CustomBottomNavigator(index: controller.getPageID()),
    );
  }
}
