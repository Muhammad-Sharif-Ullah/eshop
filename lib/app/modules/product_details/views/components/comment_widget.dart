import 'package:eshop/app/components/ratingWidget.dart';
import 'package:eshop/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentWidget extends GetWidget<ProductDetailsController> {
  const CommentWidget({
    Key? key,
    required this.index,
    required this.currentUID,
  }) : super(key: key);

  final int index;
  final String currentUID;

  @override
  Widget build(BuildContext context) {
    Widget buildLikeIcon() {
      return Obx(() {
        return controller.reviewsList[index].reviewLiked!.contains(currentUID)
            ? Icon(Icons.thumb_up_alt_sharp, color: Colors.blue)
            : Icon(Icons.thumb_up_alt_outlined);
      });
    }

    int getReviewsCont() => controller.reviewsList[index].reviewLiked!.length;
    return Container(
      width: context.width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Get.isDarkMode ? AppColors.blackDark : AppColors.backgroundLight,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000000),
                      child: buildNetWorkImage(
                          controller.reviewsList[index].avatar!),
                    ),
                    radius: 25,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.reviewsList[index].userName!),
                      // Text(reviews.createdAt.toString()),
                      RatingWidget(
                          rated: controller.reviewsList[index].rate!.toInt(),
                          peopleCount: getReviewsCont()),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 40),
                  Expanded(
                    child: Obx(() =>
                        Text("\"${controller.reviewsList[index].text!}\"")),
                  )
                ],
              ),
              SizedBox(height: 15),
              if (controller.reviewsList[index].images!.length != 0)
                SizedBox(
                  height: 80,
                  child: Obx(() => ListView.builder(
                        itemCount: controller.reviewsList[index].images!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          String url =
                              controller.reviewsList[index].images![index];
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: buildNetWorkImage(url)),
                          );
                        },
                      )),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() {
                    return Text(
                        '(${controller.reviewsList[index].reviewLiked!.length}) Likes');
                  }),
                  IconButton(
                    icon: buildLikeIcon(),
                    onPressed: () => controller.likeAComment(
                        controller.reviewsList[index].userId!,
                        controller.reviewsList[index].productId!),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Image buildNetWorkImage(String url) {
    return Image.network(
      url,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Center(
          child: Icon(Icons.error, color: Colors.redAccent),
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }
}
