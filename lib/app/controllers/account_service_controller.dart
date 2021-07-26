import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/firebase_repository/firebase_storage.dart';
import 'package:eshop/app/model/beg_model.dart';
import 'package:eshop/app/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AccountServiceController extends GetxController {
  final FirebaseAuth instance = FirebaseAuth.instance;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final RxList<BegModel> beg = RxList<BegModel>([]);
  final RxList<String> favoritesId = RxList<String>([]);
  static final accountCNT = Get.put(AccountServiceController());
  final RxDouble total = 0.0.obs;
  final RxDouble testTotal = 0.0.obs;

  @override
  onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    beg.bindStream(getBegItems());
    favoritesId.bindStream(favoritesIdAsStream());
    testTotal.listen((d) {
      for (var i in beg) testTotal.value += double.parse(i.price!);
    });
    super.onReady();
  }

  @override
  void onClose() {}

  Future<String> getDownloadLink(String url) =>
      FireBaseStorage.getDownloadLink(url);

  Stream<List<BegModel>> getBegItems() {
    return fireStore
        .collection('users/${instance.currentUser!.uid}/beg')
        .snapshots()
        .map((begs) {
      return begs.docs.map((beg) {
        final BegModel product = BegModel.fromJson(beg.data());
        FireBaseCollection.getProductData(product.id!, "old_price")
            .then((value) {
          product.setPrice = value * product.quantity;
        });
        total.value += double.parse(product.price!);
        return product;
      }).toList();
    });
  }

  Stream<List<String>> favoritesIdAsStream() {
    return fireStore
        .doc('users/${instance.currentUser!.uid}/favorites/favorites_list')
        .snapshots()
        .map((ids) {
      final List<String> data = [];
      for (var e in ids.data()!['product_id']) data.add(e);
      return data;
    });
  }

  deleteItemFromBeg(String prodId) async {
    await fireStore
        .doc('users/${instance.currentUser!.uid}/beg/$prodId')
        .delete();
  }

  Future<List<ProductModel?>> favoritesList() async {
    return await fireStore.collection('products').get().then((value) {
      List<ProductModel> favList = [];
      for (var e in value.docs)
        if (favoritesId.contains(e.id))
          favList.add(ProductModel.fromJson(e.data()));
      return favList;
    });
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var p in beg) {
      total += double.parse(p.price!);
    }
    return total;
  }
}
