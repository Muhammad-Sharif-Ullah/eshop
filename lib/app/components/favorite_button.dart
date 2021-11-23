

import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/firebase_repository/firebase_collection.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    final AccountServiceController acnCNT =
    Get.find<AccountServiceController>();
    return FloatingActionButton(
      onPressed: () {
        if (acnCNT.favoritesId.contains(id)) {
          FireBaseCollection.removeFromFavorite(id);
        } else {
          FireBaseCollection.addToMyFavorites(id);
        }
      },
      heroTag: id,
      child: GetX(
        builder: (AccountServiceController acsCNT) {
          Icon icon = acsCNT.favoritesId.contains(id)
              ? Icon(Icons.favorite, color: AppColors.primary)
              : Icon(Icons.favorite_outline_outlined, color: AppColors.grey);
          return icon;

        },
      ),
      backgroundColor:
      Get.isDarkMode ? AppColors.blackDark : AppColors.backgroundLight,
      mini: true,
    );
  }
}
