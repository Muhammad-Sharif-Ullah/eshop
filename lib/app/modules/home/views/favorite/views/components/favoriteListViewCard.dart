import 'package:eshop/app/components/cached_network_widget.dart';
import 'package:eshop/app/components/ratingWidget.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/nab_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteListCard extends StatelessWidget {
  const FavoriteListCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    int getRating() =>
        product.rating!.values.fold<int>(
            0, (previousValue, element) => (previousValue + element)) ~/
            product.rating!.length;
    int getPeopleCount()=> product.rating!.length;

    return Stack(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          color: Get.isDarkMode ? AppColors.blackDark : Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkWidget(
                    width: 200,
                    height: 130,
                    url: product.images![0],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(product.brand!,
                        style: context.textTheme.bodyText1
                            ?.copyWith(color: AppColors.grey, fontSize: 15)),
                    Text(
                      product.name!,
                      style: context.textTheme.subtitle1,
                    ),
                    Text(
                      product.category!,
                      style: context.textTheme.subtitle1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingWidget(rated: getRating(), peopleCount: getPeopleCount()),
                            Text('${product.oldPrice}\$',
                                style: context.textTheme.subtitle1
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: InkWell(
            child: Icon(Icons.close, color: Colors.red),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: InkWell(
            child: FloatingActionButton(
                onPressed: () {},
                child: Icon(NabIcon.bag_nofill, color: Colors.white),
                mini: true,
                backgroundColor: AppColors.primary),
          ),
        ),
      ],
    );
  }

  getColor() {
    return Get.isDarkMode ? Colors.white : Colors.black;
  }
}
