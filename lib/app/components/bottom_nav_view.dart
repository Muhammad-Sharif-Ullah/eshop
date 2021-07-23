//
// import 'package:eshop/app/modules/bag/views/bag_views.dart';
// import 'package:eshop/app/modules/favorites/views/favorite_views.dart';
// import 'package:eshop/app/modules/home/views/home_view.dart';
// import 'package:eshop/app/modules/profile/views/profile_views.dart';
// import 'package:eshop/app/modules/shop/views/shop_views.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// class BottomNavView extends StatelessWidget {
//   const BottomNavView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     RxInt pageIndex = 0.obs;
//     final navPages = [
//       HomeView(pageIndex: pageIndex),
//       ShopViews(pageIndex: pageIndex),
//       BagViews(pageIndex: pageIndex),
//       FavoriteViews(pageIndex: pageIndex),
//       ProfileViews(pageIndex: pageIndex)
//     ];
//     return Obx(()=> navPages[pageIndex.value]);
//   }
// }
