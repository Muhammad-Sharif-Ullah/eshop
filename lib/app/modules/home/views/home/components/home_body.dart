import 'package:eshop/app/data/data.dart';
import 'package:eshop/app/model/display_model.dart';
import 'package:eshop/app/model/model.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:eshop/app/modules/home/controllers/home_controller.dart';
import 'package:eshop/app/modules/home/views/home/components/product_Card_home.dart';
import 'package:eshop/app/modules/home/views/home/components/topSlider.dart';
import 'package:eshop/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'homeProductScrollView.dart';
import 'home_product_scroll_view_f.dart';

class HomeBody extends GetView<HomeController> {
  const HomeBody({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<AppBanner> banners = allBaners;

    return SafeArea(
      child: Column(
        children: [
          TopSlider(
            sliders: banners,
          ),
          SizedBox(height: 10),
          //   HomeProductScrollView(
          //     sectionTitle: "Sale",
          //     subTitle: 'Super summer sell',
          //     products: controller.products,
          //   ),

          Expanded(
            child: StreamBuilder<List<ProductModel>>(
                stream: controller.getProductData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        itemCount: controller.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 300,
                            mainAxisSpacing: 10),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, int index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.PRODUCT_DETAILS,
                                  arguments: controller.products[index]);
                            },
                            child: ProductCard(
                              index: index,
                            ),
                          );
                        });
                  }
                  return Center(child: Text('Loading'));
                }),
          )
        ],
      ),
    );
  }
}
