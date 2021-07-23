import 'package:eshop/app/data/data.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'comment_widget.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reviews = allReview;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.all(0),
        tilePadding: const EdgeInsets.all(0.0),
        title: Text(
          'Rating & Reviews',
        ),
        children: [
          Row(
            children: [
              Text(
                '8 Reviews',
                style: context.textTheme.headline3,
              ),
            ],
          ),
          SizedBox(height: 10),
          ...reviews.map((review) => CommentWidget(reviews: review)).toList(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
