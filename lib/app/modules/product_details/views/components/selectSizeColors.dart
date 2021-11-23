import 'package:eshop/app/components/favorite_button.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectSizeColor extends GetWidget<ProductDetailsController> {
  const SelectSizeColor({
    Key? key,
    required this.colors,
    required this.sizes,
  }) : super(key: key);
  final List<String> colors;
  final List<String> sizes;

  @override
  Widget build(BuildContext context) {
    // final
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildOutlinedButton('Size', Icons.keyboard_arrow_down, () {
          buildBottomSheet(context, sizes, "Select Size", controller.size);
        }),
        buildOutlinedButton('Color', Icons.keyboard_arrow_down, () {
          buildBottomSheet(context, colors, "Select Colors", controller.color);
        }),
        FavoriteButton(id: controller.product.id!),
      ],
    );
  }

  Future<dynamic> buildBottomSheet(BuildContext context, List<String> perameter,
      String title, RxString rxValue) {
    final double height =
        perameter.length < 10 ? context.height * .3 : context.height * .45;

    getBgColor(String value, RxString rxValue) {
      if (rxValue.value == value) return AppColors.primary;
    }

    getPrimaryColor(String value, RxString rxValue) {
      // if(rxValue.value == value) return AppColors.primary;
      if (Get.isDarkMode && (rxValue.value == value))
        return Colors.white;
      else if (!Get.isDarkMode && (rxValue.value == value))
        return Colors.white;
      else if (Get.isDarkMode && (rxValue.value != value)) return Colors.white;
      return Colors.black;
    }

    return Get.bottomSheet(
      Container(
        height: height,
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        decoration: BoxDecoration(
          color: !Get.isDarkMode
              ? AppColors.backgroundLight
              : AppColors.backgroundDark,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: context.textTheme.headline5?.copyWith(
                  color: Get.isDarkMode
                      ? AppColors.backgroundLight
                      : AppColors.backgroundDark),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 10,
                spacing: 15,
                children: [
                  for (int i = 0; i < perameter.length; i++)
                    Obx(() => OutlinedButton(
                          onPressed: () {
                            rxValue.value = perameter[i];
                          },
                          child: Text('${perameter[i]}'),
                          style: OutlinedButton.styleFrom(
                            primary: getPrimaryColor(perameter[i], rxValue),
                            backgroundColor: getBgColor(perameter[i], rxValue),
                          ),
                        )),
                ],
              ),
            )),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Close',
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: AppColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      // backgroundColor: Colors.white,
      elevation: 10,
    );
  }

  OutlinedButton buildOutlinedButton(
      String name, IconData icon, VoidCallback onTap) {
    return OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          primary: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        icon: Icon(Icons.keyboard_arrow_down),
        label: Text(name));
  }
}
