import 'package:eshop/app/components/ratingWidget.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    Key? key,
  }) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    int getRating() =>
        product.rating!.fold<int>(
            0, (previousValue, element) => (previousValue + element)) ~/
        product.rating!.length;
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
                // FutureImageWidget(urls: product.images!, height: 184,width: 200),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingWidiget(rated: getRating()),
                      Text('${product.brand}',
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.caption?.copyWith(
                              color: Colors.grey, letterSpacing: -.3)),
                      Text('${product.name}',
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.subtitle1
                              ?.copyWith(letterSpacing: -.5)),
                      priceText(context, product.oldPrice, product.newPrice),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 156,
              right: -3,
              child: FloatingActionButton(
                onPressed: () {},
                heroTag: product.id,
                child: Icon(Icons.favorite_border_sharp, color: Colors.grey),
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
                  color: product.discount! == 0
                      ? AppColors.blackDark
                      : AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  product.discount! != 0 ? "-${product.discount}%" : " New ",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text priceText(BuildContext context, String? oldP, String? newP) {
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
