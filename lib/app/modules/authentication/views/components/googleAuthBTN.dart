

import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({
    Key? key, required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 64,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)),
      child: Image.asset(AppConstant.google),
      color: Colors.white,
      onPressed: onPressed,
    );
  }
}
