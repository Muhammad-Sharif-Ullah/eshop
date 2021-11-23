import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/data/data.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:eshop/app/modules/home/controllers/home_controller.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'components/favoriteGridCard.dart';
import 'components/favoriteListViewCard.dart';

class FavoriteView extends GetView<AccountServiceController> {
  @override
  @override
  Widget build(BuildContext context) {
    getColorWhiteR() =>
        !Get.isDarkMode ? AppColors.white : AppColors.backgroundLight;
    getColor() => Get.isDarkMode ? AppColors.white : AppColors.blackLight;
    getBTNSTYLE() => TextButton.styleFrom(primary: getColor());
    RxBool isListView = false.obs;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          height: context.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: Get.isDarkMode
                    ? AppColors.backgroundDark
                    : AppColors.backgroundLight,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstant.kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Favorites',
                        style: context.textTheme.headline1,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 35,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: getColorWhiteR(),
                                  ),
                                  child: Text(
                                    'Content $index',
                                    style: context.textTheme.subtitle1
                                        ?.copyWith(color: AppColors.blackLight),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: Text("Filter"),
                            label: Icon(Icons.filter_list_rounded),
                            style: getBTNSTYLE(),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Text("Price: Lowest to high"),
                            label: Icon(Icons.keyboard_arrow_down_rounded),
                            style: getBTNSTYLE(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Obx(() => !isListView.value
                                  ? Icon(Icons.list_outlined)
                                  : Icon(Icons.grid_view)),
                              onTap: () => isListView.toggle(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstant.kPadding),
                  child: Obx(
                    () => isListView.value ? _buildListView() : buildGridView(),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridView() {
    return FutureBuilder<List<ProductModel?>>(
        future: controller.favoritesList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          final List<ProductModel?> favoriteList = snapshot.data;
          if (favoriteList.isEmpty)
            return Center(
                child: Text(
              'You have no Item in your favorite list',
              style: context.textTheme.caption,
            ));
          return GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 300, mainAxisSpacing: 10),
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                return FavoriteGridCard(product: favoriteList[index]!);
              });
        });
  }

  Widget _buildListView() {
    return FutureBuilder<List<ProductModel?>>(
      future: controller.favoritesList(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        final List<ProductModel?> favoriteList = snapshot.data;
        if (favoriteList.isEmpty)
          return Center(
              child: Text(
            'You have no Item in your favorite list',
            style: context.textTheme.caption,
          ));
        return ListView.builder(
            itemCount: favoriteList.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return FavoriteListCard(product: favoriteList[index]!);
            });
      },
    );
  }
}
