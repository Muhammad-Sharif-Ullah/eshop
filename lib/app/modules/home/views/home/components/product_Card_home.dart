import 'package:eshop/app/components/cached_network_widget.dart';
import 'package:eshop/app/components/favorite_button.dart';
import 'package:eshop/app/components/ratingWidget.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/modules/home/controllers/home_controller.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends GetWidget<HomeController> {
  const ProductCard({
    required this.index,
    Key? key,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    int getPeopleCount()=> controller.products[index].rating!.length;

    int getRating() {
      if(getPeopleCount() == 0) return 0;
      return controller.products[index].rating!.values.fold<int>(
            0, (previousValue, element) => (previousValue + element)) ~/
        controller.products[index].rating!.length;
    }
    final String id = controller.products[index].id!;
    return Container(
      width: 200,
      // height: 350,
      padding: const EdgeInsets.only(right: 8.0),
      child: Card(
        elevation: 5,
        color: Get.isDarkMode ? AppColors.blackDark : AppColors.backgroundLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkWidget(
                    url: controller.products[index].images!.first,
                    height: 184,
                    width: 200),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingWidget(rated: getRating(), peopleCount: getPeopleCount()),
                      Text(controller.products[index].brand!,
                          //'${product.brand}'
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.caption?.copyWith(
                              color: Colors.grey, letterSpacing: -.3)),
                      Text(controller.products[index].name!,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.subtitle1
                              ?.copyWith(letterSpacing: -.5)),
                      PriceText(
                          context: context,
                          oldP: controller.products[index].oldPrice,
                          newP: controller.products[index].oldPrice),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 156,
              right: -3,
              child: FavoriteButton(id: id),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: controller.products[index].discount == 0
                      ? AppColors.blackDark
                      : AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  controller.products[index].discount != 0
                      ? "-${controller.products[index].discount}%"
                      : " New ",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PriceText extends StatelessWidget {
  const PriceText({
    Key? key,
    required this.context,
    required this.oldP,
    required this.newP,
  }) : super(key: key);

  final BuildContext context;
  final String? oldP;
  final String? newP;

  @override
  Widget build(BuildContext context) {
    var priceCount = Text.rich(
      TextSpan(
        style: context.textTheme.subtitle1
            ?.copyWith(color: Colors.grey, letterSpacing: -.5),
        children: [
          if (oldP != "0")
            TextSpan(
                text: '$oldP\$',
                style: TextStyle(decoration: TextDecoration.lineThrough)),
          TextSpan(
            text: oldP != "0" ? '  ' + '$newP\$' : '$newP\$',
            style:
                context.textTheme.subtitle1?.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
    return priceCount;
  }
}
