import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MyOrderView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('MyOrderView'),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Orders',
                style: context.textTheme.headline2,
              ),
              SizedBox(height: 24),
              TabBar(
                indicatorColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: context.isDarkMode
                      ? AppColors.backgroundLight
                      : AppColors.blackDark,
                  borderRadius: BorderRadius.circular(20),
                ),
                labelPadding: EdgeInsets.symmetric(vertical: 10),
                labelColor: !context.isDarkMode ? Colors.white : Colors.black,
                unselectedLabelColor:
                    context.isDarkMode ? Colors.white : Colors.black,
                tabs: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text('Delivered'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text('Processing'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text('Cancelled'),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text('Delevered')),
                    Center(child: Text('Delevered')),
                    Center(child: Text('Delevered')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
