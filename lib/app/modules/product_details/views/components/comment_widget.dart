import 'package:eshop/app/components/ratingWidget.dart';
import 'package:eshop/app/model/model.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  final ReviewsModel reviews;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Get.isDarkMode
            ? AppColors.blackDark
            : AppColors.backgroundLight,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Image.asset(reviews.avatar),
                    radius: 25,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(reviews.userName),
                      Text(reviews.date.toUtc().toString()),
                      RatingWidiget(rated: reviews.reviewGive),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 40),
                  Expanded(
                    child: Text(reviews.review),
                  )
                ],
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                              'assets/images/all_images/banner3.png')),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('(${reviews.reviewLiked}) Likes'),
                  IconButton(
                    icon: Icon(Icons.thumb_up_alt_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
