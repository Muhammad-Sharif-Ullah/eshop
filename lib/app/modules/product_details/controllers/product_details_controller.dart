import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/app/firebase_repository/firebase_auth.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:eshop/app/model/write_comment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductDetailsController extends GetxController {
  final ProductModel product = Get.arguments;

  final RxString color = RxString('');
  final RxString size = RxString('');
  final RxList<ProductModel> relatedProd = RxList<ProductModel>([]);
  final ImagePicker _picker = ImagePicker();
  RxList<XFile?> images = RxList<XFile?>([]);
  RxBool isSubmittingReview = RxBool(false);
  RxList<WriteCommentModel> reviewsList = RxList<WriteCommentModel>([]);

  @override
  void onInit() {
    super.onInit();
    color.value = product.colors![0];
    size.value = product.sizes![0];
    getRelatedProduct();
  }

  @override
  void onReady() {
    reviewsList.bindStream(reviewsAsStream());
    super.onReady();
  }

  @override
  void onClose() {}

  getRelatedProduct() async {
    String query = product.category!;
    await FireBaseCollection.fetchRelatedProduct(query).then((prods) {
      for (Map<String, dynamic> prod in prods) {
        if (prod['id'] != product.id)
          relatedProd.add(ProductModel.fromJson(prod));
      }
    });
  }

  getImage(RxList<XFile?> images) async {
    // if (isGallery)
    // images.add((await _picker.pickImage(source: ImageSource.galler)));
    images.add(await _picker.pickImage(source: ImageSource.gallery));

    // else image.value = (await _picker.pickImage(source: ImageSource.camera))!.path;
    // print(images);
    // Get.back();
  }

  submitReview(String text, int rating) async {
    //if Text and rating are empty
    if (text.isEmpty && rating == -1)
      defaultDialog("Please give stars and write your opinion");

    //if text only empty
    else if (text.isEmpty) {
      defaultDialog("Please write your opinion");
      // if rating only empty
    } else if (rating == -1) {
      defaultDialog("Please give stars");
      //every thing is okey send request
    } else {
      // print('oky')
      DateTime currentPhoneDate = DateTime.now(); //DateTime
      Timestamp currentTimeStamp = Timestamp.fromDate(currentPhoneDate);
      final model = <String, dynamic>{
        "user_id": FireBaseAuth.user!.uid,
        "user_name": FireBaseAuth.user!.displayName,
        "avatar": FireBaseAuth.user!.photoURL,
        "product_Id": product.id,
        "text": text,
        "images": images.value,
        "rate": rating + 1,
        "created_at": currentTimeStamp,
        'reviewLiked': <String>[],
      };
      isSubmittingReview.toggle();
      await FireBaseCollection.addComment(model).then((value) {
        isSubmittingReview.toggle();
        Get.back();
      }).onError((error, stackTrace) {
        print(error.toString());
        isSubmittingReview.toggle();
      });
    }
  }

  Future<dynamic> defaultDialog(String message) {
    return Get.defaultDialog(
      title: 'Failed to submit',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
      titleStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Get.back(),
          child: Text('Ok'),
        ),
      ],
    );
  }

  Stream<List<WriteCommentModel>> reviewsAsStream() {
    return FirebaseFirestore.instance
        .collection('products/${product.id}/reviews') //9hEMmLIKKmccAUq6aY5E
        .snapshots()
        .map((event) {
      List<WriteCommentModel> reviews = [];
      for (var e in event.docs) {
        final t = WriteCommentModel.fromJson(e.data());
        reviews.add(WriteCommentModel.fromJson(e.data()));
      }
      print("Length: ${reviews.length}");
      return reviews;
    });
  }

  likeAComment(String uid, String prodID) async {
    await FireBaseCollection.likeAComment(uid, prodID);
  }
}
