import 'package:eshop/app/model/write_comment_model.dart';
import 'package:eshop/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'comment_widget.dart';

class ReviewSection extends GetWidget<ProductDetailsController> {
  const ReviewSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
            mainAxisSize  :MainAxisSize.max,
            children: [
              Obx(()=>Text(
                '${controller.reviewsList.length} Reviews',
                style: context.textTheme.headline3,
              )),
            ],
          ),
          SizedBox(height: 10),
          // ...reviews.map((review) => CommentWidget(reviews: review)).toList(),
          buildStreamBuilder(),
          // ...controller.reviewsList.map((review) => CommentWidget(reviews: review)).toList(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  StreamBuilder<List<WriteCommentModel>> buildStreamBuilder() {
    final String currentUID = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<List<WriteCommentModel>>(
          stream: controller.reviewsAsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // final RxList<WriteCommentModel>? data = RxList<WriteCommentModel>(snapshot.data!);
              // if (data!.length == 0) return Text('No Reviews');
              if (controller.reviewsList.length == 0) return Text('No Reviews');
              return Obx(()=>ListView.builder(
                physics: BouncingScrollPhysics(),
                  itemCount: controller.reviewsList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CommentWidget(index: index,currentUID: currentUID );
                  }));
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error occurred. please try again');
            }
            return Text('Loading Data');
          },
        );
  }
}
