import 'package:eshop/app/components/ratingWidget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo(
      {Key? key,
      required this.brand,
      required this.prodType,
      required this.shortInfo,
      required this.price,
      required this.rating})
      : super(key: key);
  final String brand;
  final String prodType;
  final String shortInfo;
  final double price;
  final Map<String, int> rating;

  @override
  Widget build(BuildContext context) {
    int getRating() {
      if(rating.length== 0) return 0;
      return rating.values.fold<int>(
            0, (previousValue, element) => (previousValue + element)) ~/
            rating.length;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: brand,
                style: context.textTheme.headline2
                    ?.copyWith(letterSpacing: -1, wordSpacing: -1),
                children: [
                  TextSpan(
                    text: '\n$prodType',
                    style: context.textTheme.subtitle1?.copyWith(
                        color: Colors.grey, letterSpacing: -1, wordSpacing: -1),
                  ),
                ],
              ),
            ),
            Text(
              "\$$price",
              style: context.textTheme.headline2,
            ),
          ],
        ),
        RatingWidget(rated: getRating(), peopleCount: rating.length),
        SizedBox(height: 20),
        Text(shortInfo),
        SizedBox(height: 20),
      ],
    );
  }
}

