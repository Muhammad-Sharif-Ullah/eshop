import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop/app/components/bigSplashButton.dart';
import 'package:eshop/app/components/cached_network_widget.dart';
import 'package:eshop/app/components/productCard.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/model/beg_model.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:eshop/app/modules/product_details/views/components/reviewSection.dart';
import 'package:eshop/app/modules/product_details/views/components/write_review.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:eshop/app/values/nab_icon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_details_controller.dart';
import 'components/product_info.dart';
import 'components/selectSizeColors.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    // final ProductModel product = Get.arguments;
    final ProductModel product = controller.product;

    final AccountServiceController acsCNT =
        Get.find<AccountServiceController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme:
            IconThemeData(color: Get.isDarkMode ? Colors.white : Colors.black),
        elevation: 0,
        backgroundColor: Get.isDarkMode
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        title: Text(
          product.category!,
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          SizedBox(
            height: 40,
            width: 40,
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.center,
              children: [
                Icon(NabIcon.bag_nofill),
                GetX(
                  builder: (AccountServiceController acsCNT) {
                    return (acsCNT.beg.length != 0)
                        ? Positioned(
                            right: 0,
                            top: 10,
                            child: Container(
                              height: 20,
                              width: 20,
                              padding: const EdgeInsets.all(2.4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary,
                                border: Border.all(
                                    width: 2,
                                    color: Get.isDarkMode
                                        ? AppColors.blackDark
                                        : Colors.white),
                              ),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  '${acsCNT.beg.length}',
                                  style: context.textTheme.caption
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ))
                        : Container();
                  },
                ),
              ],
            ),
          ),
          SizedBox(width: 24),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 350,
              // color: Colors.red,
              width: context.width,
              child: CarouselSlider.builder(
                itemCount: product.images!.length,
                options: CarouselOptions(
                  autoPlay: true,
                  height: 200,
                  // aspectRatio: 16 / 9,
                  aspectRatio: 2.0,
                  viewportFraction: 0.9,
                  reverse: false,
                  // initialPage: 2,
                ),
                itemBuilder: (context, itemIndex, pageViewIndex) {
                  final String image = product.images![itemIndex];
                  return CachedNetworkWidget(
                    url: image,
                    height: 184,
                    width: 200,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstant.kPadding),
              child: Column(
                children: [
                  SelectSizeColor(
                    colors: product.colors!,
                    sizes: product.sizes!,
                  ),
                  ProductInfo(
                    brand: product.brand!,
                    price: double.parse(product.oldPrice!), //TODO? Deside later
                    prodType: product.category!,
                    rating: product.rating!, //TODO: Testing
                    shortInfo: product.description!,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstant.kPadding),
              child: BigSplashButton(
                height: 48,
                width: context.width,
                text: "Add To Cart",
                onPressed: () async {
                  await FireBaseCollection.addToBeg(
                      begMap: BegModel.productToBeg(controller.product,
                          controller.color.value, controller.size.value, 1));
                  Get.rawSnackbar(
                    messageText: Center(child: Text("Item added in your card")),
                    animationDuration: Duration(milliseconds: 400),
                    dismissDirection: SnackDismissDirection.HORIZONTAL,
                    duration: Duration(milliseconds: 700),
                    snackPosition: SnackPosition.TOP,
                  );
                },
              ),
            ),
            ReviewSection(),
            // Expanded(
            //   child: Container(),
            // ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(AppConstant.kPadding),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'You may also like',
                        style: context.textTheme.headline3,
                      ),
                      Obx(
                        () => Text(
                          '${controller.relatedProd.length} Items',
                          style: context.textTheme.caption,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  //TODO: Fix Product Card
                  Container(
                    height: 300,
                    child: Obx(() => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.relatedProd.length,
                          itemBuilder: (context, int index) {
                            return ProductCard(
                                product: controller.relatedProd[index]);
                          },
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'Write Comments',
        onPressed: () {
          Get.to(
            () => WriteReview(),
            transition: Transition.downToUp,
            duration: Duration(milliseconds: 700),
            // curve: Curves.easeInToLinear
            curve: Curves.fastLinearToSlowEaseIn,
            // curve: Curves.fastOutSlowIn,
          );
        },
        backgroundColor: AppColors.success,
        icon: Icon(Icons.edit, color: Colors.white),
        label: Text('Write a review', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
