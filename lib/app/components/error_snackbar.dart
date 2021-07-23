import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorSnackBar(String title, String message) => Get.snackbar(
      title,
      message,
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.error),
      colorText: Colors.white,
    );
