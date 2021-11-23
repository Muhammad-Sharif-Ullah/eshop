import 'package:eshop/app/controllers/account_service_controller.dart';
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
    final AccountServiceController ascCNT = Get.find<AccountServiceController>();
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: Container(
        height: 80,
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
                      icon: BottomIconWidget(
                        currentIndex: index.value,
                        pageIndex: 2,
                        icon: NabIcon.shopping_bag,
                        value: ascCNT.beg.length,
                      ),
                      label: "Beg"),
                  BottomNavigationBarItem(
                      icon: BottomIconWidget(
                        currentIndex: index.value,
                        pageIndex: 2,
                        icon: NabIcon.heart,
                        value: ascCNT.favoritesId.length,
                      ),
                      label: "Favorites"),
                  BottomNavigationBarItem(
                      icon: Icon(NabIcon.profile), label: "Profile"),
                ],
              ),
            )),
      ),
    );
  }
}

class BottomIconWidget extends StatelessWidget {
  const BottomIconWidget({
    Key? key,
    required this.currentIndex,
    required this.pageIndex,
    required this.icon,
    required this.value,
  }) : super(key: key);
  final int currentIndex;
  final int pageIndex;
  final IconData icon;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 50,
          // height: 30,
          child: Icon(icon),
        ),
        if (value!=0)
          Positioned(
            right: 1,
            top: -2,
            child: Container(
              height: 18,
              width: 18,
              padding: const EdgeInsets.all(2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == pageIndex
                    ? AppColors.primary
                    : AppColors.primary,
                border: Border.all(
                    width: 2,
                    color: Get.isDarkMode ? AppColors.blackDark : Colors.white),
              ),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(value.toString(),
                    style: context.textTheme.caption
                        ?.copyWith(color: Colors.white)),
              ),
            ),
          ),
      ],
    );
  }
}
