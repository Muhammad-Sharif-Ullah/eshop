import 'dart:io';

import 'package:eshop/app/components/bigSplashButton.dart';
import 'package:eshop/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WriteReview extends GetWidget<ProductDetailsController> {
  WriteReview({Key? key}) : super(key: key);
  final TextEditingController _reviewText = TextEditingController();
  RxInt selectRange = RxInt(-1);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async {
        controller.images.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Container(
          height: context.height * .9,
          width: context.width,
          padding: const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'What is your rate?',
                      style: context.textTheme.headline2,
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: context.width * .7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < 5; i++)
                            InkWell(
                              onTap: () => selectRange.value = i,
                              child: Obx(() => i <= selectRange.value
                                  ? buildSelectedIcon()
                                  : buildUnselectedIcon()),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Please share your opinion about the product',
                        style: context.textTheme.headline6?.copyWith(
                            color: !Get.isDarkMode ? Colors.black : Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        // height: context.height * .28,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? AppColors.blackDark
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(1, 1),
                              blurRadius: 4,
                              color: Get.isDarkMode
                                  ? AppColors.blackDark.withOpacity(0.8)
                                  : Colors.grey.withOpacity(0.4),
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _reviewText,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Write Your Review"),
                          maxLines: (context.height * .28) ~/ 2,
                          maxLength: 140,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Obx(() => controller.images.length != 0
                        ? Expanded(
                            child: GridView.builder(
                              itemCount: controller.images.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, int index) {
                                return buildGestureImage(
                                    RxBool(false), controller.images, index);
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 200,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 5,
                              ),
                            ),
                          )
                        : Container()),
                    // _imageAddButton(context, controller.images),
                    SizedBox(height: 20),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: TextButton.icon(
                          onPressed: () => controller.getImage(controller.images),
                          icon: Icon(Icons.camera_alt),
                          label: Text('Add your photos')),
                    ),
                    SizedBox(height: 20),
                    Obx(() =>
                        controller.images.length == 0 ? Spacer() : SizedBox()),
                    Obx(() => controller.isSubmittingReview.value
                        ? SizedBox(
                            height: 48,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Submitting review. pleas wait',style: context.textTheme.caption),
                                ),
                                LinearProgressIndicator(color: AppColors.primary,),
                              ],
                            ),
                          )
                        : buildSubmitReview(context)),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  BigSplashButton buildSubmitReview(BuildContext context) {
    return BigSplashButton(
      height: 48,
      width: context.width,
      text: "Submit Review",
      onPressed: () =>
          controller.submitReview(_reviewText.text.trim(), selectRange.value),
    );
  }

  Expanded buildImageListWidget(RxList<XFile?> images) {
    RxBool showDelete = RxBool(false);
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: images.length, //items + 1 = 10->item
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildGestureImage(showDelete, images, index);
        },
      ),
    );
  }

  GestureDetector buildGestureImage(
      RxBool showDelete, RxList<XFile?> images, int index) {
    return GestureDetector(
      onTap: () => showDelete.value = false,
      onLongPress: () => showDelete.toggle(),
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File(images[index]!.path),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Obx(() => showDelete.value
              ? Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
              : Container()),
          Obx(() => showDelete.value
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: InkWell(
                        onTap: () {
                          controller.images.removeAt(index);
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color: AppColors.white,
                          size: 70,
                        )),
                  ),
                )
              : Container()),
        ],
      ),
    );
  }

  Icon buildUnselectedIcon() {
    return Icon(
      Icons.star_border_sharp,
      color: Colors.grey,
      size: 35,
    );
  }

  Icon buildSelectedIcon() {
    return Icon(
      Icons.star,
      color: Color(0xFFFFBA49),
      size: 35,
    );
  }

  Widget _imageAddButton(BuildContext context, RxList<XFile?> images) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: () {
            controller.getImage(images);
          },
          child: Icon(Icons.camera_alt, color: Colors.white),
          backgroundColor: AppColors.primary,
        ),
        SizedBox(height: 10),
        Text(
          'Add your photos',
          style: context.textTheme.caption,
        )
      ],
    );
  }
}
