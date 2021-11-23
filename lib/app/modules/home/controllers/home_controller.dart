import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/app/firebase_repository/firebase_storage.dart';
import 'package:eshop/app/model/display_model.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:eshop/app/modules/home/views/beg/views/beg_view.dart';
import 'package:eshop/app/modules/home/views/category/views/category_view.dart';
import 'package:eshop/app/modules/home/views/favorite/views/favorite_view.dart';
import 'package:eshop/app/modules/home/views/home/components/home_body.dart';
import 'package:eshop/app/modules/home/views/profile/views/profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeController extends GetxController {
  final RxInt pageIndex = 0.obs;
  final FirebaseAuth instance = FirebaseAuth.instance;
  final storage = firebase_storage.FirebaseStorage.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Rx<User?> user = FirebaseAuth.instance.currentUser.obs;
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<DisplayProduct> displayProucts = RxList<DisplayProduct>([]);
  final List<StatelessWidget> allPages = [
    HomeBody(),
    CategoryView(),
    BegView(),
    FavoriteView(),
    ProfileView(),
  ];

  get currentBody => allPages[pageIndex.value];

  @override
  onInit() {
    user.bindStream(instance.userChanges());
    products.bindStream(getProductData());
    // fetchtDisplayProducts();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void nextPageID(int value) => pageIndex.value = value;

  RxInt getPageID() => pageIndex;

  Stream<List<ProductModel>> getProductData() {
    return fireStore.collection('products').snapshots().map((query) {
      return query.docs.map((product) {
        return ProductModel.fromJson(product.data());
      }).toList();
    });
  }

  Future<String> getDownloadLink(String url) =>
      FireBaseStorage.getDownloadLink(url);

  Future<List<DisplayProduct>> fetchtDisplayProducts() async {
    final List<DisplayProduct> prod = [];
    return await fireStore.collection('display_products').get().then((dPID) {
      dPID.docs.forEach((element) {
        final DisplayProduct item = DisplayProduct.fromJson(element.data());
        prod.add(item);
      });
      return prod;
    });
  }
  // addToMyBeg(ProductModel product)async{
  //
  //   await FireBaseCollection.addToBeg(
  //       begMap: BegModel.productToBeg(product,
  //           product.colors![0], product.sizes![0], 1));
  // }
}
