import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MyReviewsView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyReviewsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MyReviewsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
