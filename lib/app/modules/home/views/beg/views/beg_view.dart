import 'package:eshop/app/components/bigSplashButton.dart';
import 'package:eshop/app/modules/home/controllers/home_controller.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'components/bagCard.dart';



class BegView extends GetView<HomeController> {
  const BegView( {Key? key, }) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                color: Get.isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
                elevation: 10,
                child: Container(
                  width: context.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppConstant.kPadding, right: 8, bottom: 8),
                    child: Text(
                      'My Bag',
                      style: context.textTheme.headline2,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
                child: Column(
                  children: [
                    SizedBox(height: 4),
                    ...List.generate(10, (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: BagCard(),
                    )),

                    SizedBox(height: 14),

                    Divider(thickness: 3,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Amount', style: context.textTheme.subtitle2),
                        Text('500\$', style: context.textTheme.headline3,),
                      ],
                    ),
                    SizedBox(height: 24),
                    BigSplashButton(height: 48, width: context.width, text: "CHECT OUT", onPressed: (){}),
                    SizedBox(height: 14),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
