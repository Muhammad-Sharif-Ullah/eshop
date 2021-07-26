import 'package:eshop/app/components/cached_network_widget.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:eshop/app/values/nab_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eshop/app/model/model.dart';
import 'package:eshop/app/values/appColors.dart';


class FavoriteGridCard extends StatelessWidget {
  const FavoriteGridCard({
    required this.product,
    Key? key,
  }) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Get.isDarkMode
          ? AppColors.blackDark
          : AppColors.backgroundLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkWidget(width: 200, height: 184,url: product.images![0],),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 15, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ratingText(product.rating!.length),
                    Text('${product.brand}', overflow: TextOverflow.ellipsis,
                        style: context.textTheme.caption?.copyWith(
                            color: Colors.grey, letterSpacing: -.3)),
                    Text('${product.category}', overflow: TextOverflow.ellipsis,
                        style: context.textTheme.subtitle1
                            ?.copyWith(letterSpacing: -.5)),
                    priceText(context, double.parse(product.oldPrice!), double.parse(product.newPrice!)),
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
              child: Icon(NabIcon.bag_nofill, color: Colors.white),
              backgroundColor: AppColors.primary,
              mini: true,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color:  product.brand!.isAlphabetOnly ? AppColors.blackDark : AppColors.primary ,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                product.discount.toString(),
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text priceText(BuildContext context, double? oldP, double? newP) {
    var priceCount = Text.rich(
      TextSpan(
        style: context.textTheme.subtitle1
            ?.copyWith(color: Colors.grey, letterSpacing: -.5),
        children: [
          if (oldP != 0)
            TextSpan(
                text: '$oldP\$',
                style: TextStyle(decoration: TextDecoration.lineThrough)),
          TextSpan(
            text: oldP != 0 ? '  ' + '$newP\$' : '$newP\$',
            style:
            context.textTheme.subtitle1?.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
    return priceCount;
  }

  Text ratingText(int rated) {
    String rate = "★";
    String notRated = "☆";
    var rateCount = Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 14, color: Colors.grey),
        children: [
          TextSpan(
              text: '${rate * rated}',
              style: TextStyle(color: Color(0xFFFFBA49), fontSize: 16)),
          TextSpan(text: '${notRated * (5 - rated)}'),
          TextSpan(text: '(10)'),
        ],
      ),
    );
    return rateCount;
  }
}
