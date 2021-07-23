import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop/app/firebase_repository/firebase_storage.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:eshop/app/modules/product_details/views/components/reviewSection.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
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
    int getRating() =>
        product.rating!.fold<int>(
            0, (previousValue, element) => (previousValue + element)) ~/
        product.rating!.length;

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
                  return FutureBuilder<String>(
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapShot) {
                      if (snapShot.hasData) return Image.network(snapShot.data);
                      return Center(child: Text('Loading'));
                    },
                    future: FireBaseStorage.getDownloadLink(image),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstant.kPadding),
              child: Column(
                children: [
                  SelectSizeColor(colors: product.colors!, sizes: product.sizes!,),
                  ProductInfo(
                    brand: product.brand!,
                    price: double.parse(product.newPrice!),
                    prodType: product.category!,
                    rating: getRating(),
                    shortInfo:
                        "Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed",
                  ),
                ],
              ),
            ),
            ReviewSection(),
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
                      Text(
                        '12 items',
                        style: context.textTheme.caption,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //TODO: Fix Product Card
                  // Container(
                  //   height: 300,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: saleProducts.length,
                  //     itemBuilder: (context, int index) {
                  //       return ProductCard(product: saleProducts[index]);
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'Write Comments',
        onPressed: () {
          Get.bottomSheet(
            Container(
              height: context.height * .7,
              width: context.width,
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? AppColors.backgroundDark
                    : AppColors.backgroundLight,
              ),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        icon: Icon(Icons.edit, color: Colors.white),
        label: Text('Write a review', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
