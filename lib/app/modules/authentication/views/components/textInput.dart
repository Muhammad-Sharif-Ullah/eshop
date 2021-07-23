

import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key, required this.label, required this.hintText, required this.controller, required this.inputType,
    required this.validator,
  }) : super(key: key);

  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: inputType,
      decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          hintText: hintText,
      ),
    );
  }

  String? name(va){
      return null;
    }
}
