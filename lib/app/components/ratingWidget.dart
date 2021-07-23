import 'package:flutter/material.dart';

class RatingWidiget extends StatelessWidget {
  const RatingWidiget( {Key? key, required this.rated}) : super(key: key);
  final int rated;

  @override
  Widget build(BuildContext context) {
    final String rate = "★";
    final String notRated = "☆";
    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 14, color: Colors.grey),
        children: [
          TextSpan(
              text: '${rate * rated}',
              style: TextStyle(color: Color(0xFFFFBA49), fontSize: 16)),
          TextSpan(text: '${notRated * (5 - rated)}'),
          // TextSpan(text: '(10)'),
        ],
      ),
    );
  }
}
