import 'dart:io';

import 'package:eshop/app/components/error_snackbar.dart';
import 'package:eshop/app/firebase_repository/firebase_auth.dart';
import 'package:eshop/app/modules/authentication/views/components/loginView.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController {
  final RxBool isRequesting = false.obs;
  final ImagePicker _picker = ImagePicker();
  final Rx<String> image = Rx<String>('');
  final RxBool visibility = RxBool(true);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<bool> signUp(email, password, name) => FireBaseAuth.signUp(
      email, password, name, isRequesting, File(image.value));
  Future<bool> login(email, password) =>
      FireBaseAuth.login(email, password, isRequesting);

  /// a dialog pop-up for a user to choose
  /// from where he want to choose image source
  chooseImageSource() {
    Get.defaultDialog(
        title: 'Select Image Source',
        content: Container(),
        actions: [
          ElevatedButton.icon(
            onPressed: () => getImage(true),
            icon: Icon(Icons.photo_album),
            label: Text('Gallery'),
          ),
          ElevatedButton.icon(
              onPressed: () => getImage(false),
              icon: Icon(Icons.camera),
              label: Text('Camera')),
        ]);
  }

  /// Select image from gallery or camera
  /// save the image path to the image variable
  getImage(bool isGallery) async {
    if (isGallery)
      image.value =
          (await _picker.pickImage(source: ImageSource.gallery))!.path;
    else
      image.value = (await _picker.pickImage(source: ImageSource.camera))!.path;
    print(image.value);
    Get.back();
  }

  resetPass(String email) async {
    isRequesting.toString();
    final Map<String, dynamic> request =
        await FireBaseAuth.resetPassword(email);
    if (request['status']) {
      isRequesting.toString();
      Get.rawSnackbar(
        title: "Resset Success",
        message: "Please your E-mail to reset your password",
        icon: Icon(Icons.done),
        backgroundColor: AppColors.success,
        duration: Duration(seconds: 2),
        mainButton: ElevatedButton(
            onPressed: () => Get.to(LoginView()), child: Text("Log in now")),
      );
      Future.delayed(Duration(seconds: 2), () {})
          .whenComplete(() => Get.to(() => LoginView()));
    } else {
      errorSnackBar("Password Reset Faild!", request['message']);

      isRequesting.toString();
    }
  }
}
