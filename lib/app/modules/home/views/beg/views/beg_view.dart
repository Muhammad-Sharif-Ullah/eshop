import 'package:eshop/app/components/bigSplashButton.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/model/beg_model.dart';
import 'package:eshop/app/routes/app_pages.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'components/bagCard.dart';

class BegView extends GetView<AccountServiceController> {
  const BegView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final begCNT = Get
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              color: Get.isDarkMode
                  ? AppColors.backgroundDark
                  : AppColors.backgroundLight,
              elevation: 10,
              child: Container(
                width: context.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: AppConstant.kPadding, right: 8, bottom: 8),
                  child: Text(
                    'My Bag',
                    style: context.textTheme.headline2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstant.kPadding),
                child: Obx((){
                  controller.total.value = controller.getTotalPrice();
                  return ListView.builder(
                        itemCount: controller.beg.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, int index) {
                          return BegCard(beg: controller.beg[index], index: index);
                        });
                }
                ),
                // child: StreamBuilder<List<BegModel>>(
                //     stream: controller.getBegItems(),
                //     builder: (context, snapshot) {
                //       controller.total.value = 0.0;
                //       if (snapshot.hasData) {
                //         if (snapshot.data!.isEmpty)
                //           return Center(
                //               child: Text(
                //             'You have no Item in your beg',
                //             style: context.textTheme.caption,
                //           ));
                //         if (snapshot.data!.isNotEmpty) {
                //           // final List<BegModel> beg = snapshot.data!;
                //           // controller.totalAmountAR.addAll(item);
                //           // print("Length = ${beg.length}");
                //           // print("AL = ${controller.totalAmountAR.length}");
                //           return ListView.builder(
                //               itemCount: controller.beg.length,
                //               physics: BouncingScrollPhysics(),
                //               itemBuilder: (context, int index) {
                //                 return BegCard(beg: controller.beg[index], index: index);
                //               });
                //         }
                //       } else if (snapshot.hasError)
                //         return Text(snapshot.error.toString());
                //       return Center(child: Text('Loading'));
                //     }),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
              child: Divider(
                thickness: 3,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount', style: context.textTheme.subtitle2),
                  Obx(() => Text(
                        '${controller.total.value.toPrecision(2)}\$',
                        style: context.textTheme.headline3,
                      )),
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
              child: BigSplashButton(
                  height: 48,
                  width: context.width,
                  text: "CHECK OUT",
                  onPressed: () {
                   // controller.getTotalPrice();
                    print(controller.favoritesId);
                  }),
            ),
            SizedBox(height: 14),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: AppConstant.kPadding),
            //   child: Column(
            //     children: [
            //       SizedBox(height: 4),
            //       // ...List.generate(10, (index) => Padding(
            //       //   padding: const EdgeInsets.only(bottom: 8),
            //       //   child: BagCard(),
            //       // )),
            //       StreamBuilder<List<BegModel>>(
            //           stream: controller.getBegItems(),
            //           builder: (context, snapshot) {
            //             if (snapshot.hasData) {
            //               print(snapshot.data!.length);
            //               return ListView.builder(
            //                 itemCount: controller.beg.length,
            //                   itemBuilder: (context, int index) {
            //                 return Text('HI');
            //               });
            //             }
            //             return Center(child: Text('Loading'));
            //           }),
            //
            //       SizedBox(height: 14),
            //
            //       Divider(
            //         thickness: 3,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text('Total Amount',
            //               style: context.textTheme.subtitle2),
            //           Text(
            //             '500\$',
            //             style: context.textTheme.headline3,
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: 24),
            //       BigSplashButton(
            //           height: 48,
            //           width: context.width,
            //           text: "CHECT OUT",
            //           onPressed: () {}),
            //       SizedBox(height: 14),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
