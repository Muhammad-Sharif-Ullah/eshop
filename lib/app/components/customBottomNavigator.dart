
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/nab_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomBottomNavigator extends StatelessWidget {
  const CustomBottomNavigator({
    Key? key,
    required this.index,
  }) : super(key: key);

  final RxInt index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: Container(
        // height: 80,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Get.isDarkMode
                  ? AppColors.blackDark.withOpacity(0.2)
                  : Colors.white.withOpacity(0.1),
              offset: Offset(5, -5),
              blurRadius: 25,
              // color: Colors.red.shade50,
            )
          ],
        ),
        child: Obx(() => Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: BottomNavigationBar(
            currentIndex: index.value,
            onTap: (int i) => index.value = i,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(NabIcon.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: "Category"),
              BottomNavigationBarItem(
                  icon: Icon(NabIcon.shopping_bag), label: "Beg"),
              BottomNavigationBarItem(
                  icon: Icon(NabIcon.heart), label: "Favorites"),
              BottomNavigationBarItem(
                  icon: Icon(NabIcon.profile), label: "Profile"),
            ],
          ),
        )),
      ),
    );
  }
}
