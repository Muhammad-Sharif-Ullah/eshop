import 'package:eshop/app/components/cached_network_widget.dart';
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
    int getRating() =>
        controller.products[index].rating!.fold<int>(
            0, (previousValue, element) => (previousValue + element)) ~/
        controller.products[index].rating!.length;
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
                // String url = (urls..shuffle()).first;

                // FutureImageWidget(url: controller.products[index].images!.first, height: 184,width: 200),
                CachedNetworkWidget(
                    url: controller.products[index].images!.first,
                    height: 184,
                    width: 200),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingWidiget(rated: getRating()),
                      Text(controller.products[index].brand!,
                          //'${product.brand}'
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.caption?.copyWith(
                              color: Colors.grey, letterSpacing: -.3)),
                      Text(controller.products[index].name!,

                          ///'${product.name}'
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
              child: FloatingActionButton(
                onPressed: () {
                  FireBaseCollection.addToMyFavorites(
                      controller.products[index].id!);
                },
                heroTag: controller.products[index].id,
                child: GetX(
                  builder: (AccountServiceController acsCNT) {
                    Icon icon = acsCNT.favoritesId
                            .contains(controller.products[index].id)
                        ? Icon(Icons.favorite, color: AppColors.primary)
                        : Icon(Icons.favorite_outline_outlined,
                            color: AppColors.grey);
                    return icon;///TODO: add Delete option
                  },
                ),
                backgroundColor: Get.isDarkMode
                    ? AppColors.blackDark
                    : AppColors.backgroundLight,
                mini: true,
              ),
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
