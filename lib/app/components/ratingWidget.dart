import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget( {Key? key, required this.rated, required this.peopleCount}) : super(key: key);
  final int rated;
  final int peopleCount;
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
          if(peopleCount!=0)
          TextSpan(text: ' ($peopleCount)'),
        ],
      ),
    );
  }
}
