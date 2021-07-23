
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class InputBoxWidget extends GetView {
  const InputBoxWidget({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode ? AppColors.blackDark : Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            color: Color(0xFF000000).withOpacity(0.2),
            blurRadius: 2,
            // spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: child,
      ),
    );
  }
}
