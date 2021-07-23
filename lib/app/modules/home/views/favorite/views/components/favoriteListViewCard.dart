import 'package:eshop/app/components/ratingWidget.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/nab_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteListCard extends StatelessWidget {
  const FavoriteListCard({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          color: Get.isDarkMode ? AppColors.blackDark : Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset("assets/images/all_images/bag1.png", height: 130, fit: BoxFit.cover,)),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Pullover', style: context.textTheme.bodyText1?.copyWith(color: AppColors.grey,fontSize: 15)),
                    Text('Shirt', style: context.textTheme.subtitle1,),
                    Text.rich(
                      TextSpan(
                          text: 'Color: ',
                          style: context.textTheme.bodyText1?.copyWith(color: Colors.grey, fontSize: 13),
                          children: [
                            TextSpan(
                              text: "Black",
                              style: context.textTheme.bodyText1,
                            ),
                            TextSpan(
                              style: context.textTheme.bodyText1?.copyWith(color: Colors.grey),
                              text: "  Size: ",
                            ),
                            TextSpan(
                              style: context.textTheme.bodyText1,
                              text: "L",
                            ),
                          ]
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingWidiget(rated: 4),
                            Text('50\$', style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 10,

          child: InkWell(
            child: Icon(Icons.close, color: Colors.red),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,

          child: InkWell(
            child: FloatingActionButton(onPressed: (){}, child: Icon(NabIcon.bag_nofill, color: Colors.white), mini: true, backgroundColor: AppColors.primary),
          ),
        ),
      ],
    );
  }

  getColor() {
    return Get.isDarkMode ? Colors.white : Colors.black;
  }
}
