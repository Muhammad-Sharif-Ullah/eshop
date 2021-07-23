import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/app/firebase_repository/firebase_storage.dart';
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

class AccountServiceController extends GetxController {
  final FirebaseAuth instance = FirebaseAuth.instance;
  final storage = firebase_storage.FirebaseStorage.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;



  @override
  onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


  Future<String> getDownloadLink(String url) => FireBaseStorage.getDownloadLink(url);
}
