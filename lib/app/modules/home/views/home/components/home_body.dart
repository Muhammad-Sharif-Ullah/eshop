import 'package:eshop/app/data/data.dart';
import 'package:eshop/app/model/model.dart';
import 'package:eshop/app/modules/home/controllers/home_controller.dart';
import 'package:eshop/app/modules/home/views/home/components/topSlider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'homeProductScrollView.dart';


class HomeBody extends GetView<HomeController> {
  const HomeBody( {Key? key, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<AppBanner> banners = allBaners;


    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            TopSlider(
              sliders: banners,
            ),
            SizedBox(height: 10),
            HomeProductScrollView(
              sectionTitle: "Sale",
              subTitle: 'Super summer sell',
              products: controller.products,
            ),
            // HomeProductScrollView(
            //   sectionTitle: "New",
            //   subTitle: 'You never seen it before!',
            //   products: newProducts,
            // ),
          ],
        ),
      ),
    );
  }
}
