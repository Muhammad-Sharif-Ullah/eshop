import 'package:eshop/app/components/bigSplashButton.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/model/beg_mdoel_f.dart';
import 'package:eshop/app/model/beg_model.dart';
import 'package:eshop/app/modules/home/views/beg/views/checkout_view.dart';
import 'package:eshop/app/modules/home/views/beg/views/components/bag_card_F.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'components/bagCard.dart';
import 'components/bag_card_t.dart';
import 'components/beg_card_m.dart';
// import 'components/bag_card_FF.dart';

class BegView extends GetView<AccountServiceController> {
  const BegView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getTotalPrice();
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
                // child: StreamBuilder<List<BegModel>>(
                //     stream: controller.getBegAsStream(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         if (snapshot.data!.isEmpty)
                //           return Center(child: Text('No product in your beg'));
                //         else {
                //           return ListView.builder(
                //               itemCount: controller.beg.length,
                //               physics: BouncingScrollPhysics(),
                //               itemBuilder: (context, int index) {
                //                 return BegCard(
                //                     beg: controller.beg[index], index: index);
                //               });
                //         }
                //       }
                //       return Center(child: Text('Loading'));
                //     }),
                child: buildObx(context),
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

            ///TODO: change the gui
            ...totalListWidget(context),
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

  Obx buildObx(BuildContext context) {
    return Obx(() {
      // controller.total.value = controller.getTotalPrice();
      if (controller.beg.isEmpty)
        return Center(
            child: Text(
          'You have no Item in your beg',
          style: context.textTheme.caption,
        ));
      return ListView.builder(
          itemCount: controller.beg.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, int index) {
            final Rx<BegModel> item = controller.beg[index].obs;
            // return BegCardFF(index: index, beg: item);
            return BegCardM(
                index: index, pID: controller.beg[index].id!, beg: item);
            // return BegCard(index: index, beg: controller.beg[index]);
          });
    });
  }

  List<Widget> totalListWidget(BuildContext context) {
    return [
      Obx(() => controller.total.value == 0.0
          ? Container()
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
              child: Divider(
                thickness: 3,
              ),
            )),
      Obx(() => controller.total.value == 0.0
          ? Container()
          : Padding(
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
            )),
      SizedBox(height: 24),
      Obx(() => controller.total.value == 0.0
          ? Container()
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
              child: BigSplashButton(
                  height: 48,
                  width: context.width,
                  text: "CHECK OUT",
                  onPressed: () => Get.to(() => CheckoutView())),
            )),
      SizedBox(height: 14)
    ];
  }
}
