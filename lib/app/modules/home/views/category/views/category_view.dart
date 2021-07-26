import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/modules/home/controllers/home_controller.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryView extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    final String uid = controller.user.value!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Category View'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
          child: Center(child: Text('Category Working')),
        ),
      ),
    );
  }
}
