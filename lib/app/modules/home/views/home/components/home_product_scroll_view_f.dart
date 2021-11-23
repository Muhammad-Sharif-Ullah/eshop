import 'package:eshop/app/model/product_model.dart';
import 'package:eshop/app/modules/home/controllers/home_controller.dart';
import 'package:eshop/app/modules/home/views/home/components/product_Card_home.dart';
import 'package:eshop/app/routes/app_pages.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeProductScrollViewF extends GetWidget<HomeController> {
  const HomeProductScrollViewF({
    required this.sectionTitle,
    required this.subTitle,
    required this.products,
    Key? key,
  }) : super(key: key);

  final String sectionTitle;
  final String subTitle;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360, //360
      // color: Colors.grey.shade600,
      padding: const EdgeInsets.only(left: AppConstant.kPadding),
      child: Column(
        children: [
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(right: AppConstant.kPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: sectionTitle,
                    style: context.textTheme.headline2,
                  ),
                  TextSpan(
                    text: '\n$subTitle',
                    style: context.textTheme.bodyText1,
                  ),
                ])),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View all',
                    style: context.textTheme.bodyText1?.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(child: Container(color: Colors.red[200])),
          // Expanded(
          //   // height: 265,
          //   child: StreamBuilder<List<ProductModel>>(
          //       stream: controller.getProductData(),
          //       builder: (context, snapshot) {
          //         if (snapshot.hasData) {
          //           return ListView.builder(
          //               scrollDirection: Axis.horizontal,
          //               itemCount: products.length,
          //               physics: BouncingScrollPhysics(),
          //               itemBuilder: (context, int index) {
          //                 return InkWell(
          //                   onTap: () {
          //                     Get.toNamed(Routes.PRODUCT_DETAILS,
          //                         arguments: products[index]);
          //                   },
          //                   child: ProductCard(
          //                     index: index,
          //                   ),
          //                 );
          //               });
          //         }
          //         return Center(child: Text('Loading'));
          //       }),
          // ),
        ],
      ),
    );
  }
}
