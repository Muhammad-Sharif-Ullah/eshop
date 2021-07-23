import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/material.dart';

class BigSplashButton extends StatelessWidget {
  const BigSplashButton({
    required this.height,
    required this.width,
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final double height;
  final double width;
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0)),
      color: AppColors.primary,
      child: Text(text,
          style: Theme.of(context).textTheme.subtitle1
              ?.copyWith(color: Colors.white)),
      onPressed: onPressed,
    );
  }
}
