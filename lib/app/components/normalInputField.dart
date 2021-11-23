import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NormalInputField extends StatelessWidget {
  const NormalInputField({
    Key? key,
    required this.inputType,
    required this.label,
    required this.hintText,
    required this.textController,
    required this.validator,
  }) : super(key: key);

  final TextInputType inputType;
  final String label;
  final String hintText;
  final TextEditingController textController;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 5,
      color: Get.isDarkMode ? AppColors.blackDark : AppColors.backgroundLight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          keyboardType: inputType,
          controller: textController,
          validator: validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey),
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
