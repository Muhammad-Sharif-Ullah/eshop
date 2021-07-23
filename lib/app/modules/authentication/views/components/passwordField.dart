import 'package:eshop/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordField extends GetWidget<AuthenticationController> {
  const PasswordField(
      {Key? key,
      required this.label,
      required this.hintText,
      required this.passCNT,
      required this.validator})
      : super(key: key);

  final String label;
  final String hintText;
  final TextEditingController passCNT;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return  Obx(()=>TextFormField(
      controller: passCNT,
      validator: validator,
      // keyboardType: TextInputType.visiblePassword,
      obscureText: controller.visibility.value,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        hintText: hintText,
        suffixIcon: IconButton(
          icon: controller.visibility.value
              ? Icon(Icons.visibility, color: AppColors.primary)
              : Icon(Icons.visibility_off, color: AppColors.primary),
          onPressed: () {
            print('calling');
            print(controller.visibility.value);
            controller.visibility.toggle();
            print(controller.visibility.value);
          },
        ),
      ),
    ));
  }
}
