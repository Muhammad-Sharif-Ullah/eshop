import 'package:eshop/app/values/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BagCard extends StatelessWidget {
  const BagCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          color: Get.isDarkMode
              ? AppColors.blackDark
              : AppColors.backgroundLight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset("assets/images/all_images/bag1.png", height: 130, fit: BoxFit.cover,filterQuality: FilterQuality.high,)),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Pullover', style: context.textTheme.subtitle1,),
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
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FloatingActionButton(onPressed: (){}, child: Icon(Icons.remove, color: getColor()), mini: true,),
                            SizedBox(width: 10),
                            Text('1'),
                            SizedBox(width: 10),
                            FloatingActionButton(onPressed: (){}, child: Icon(Icons.add, color: getColor()), mini: true),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 14.0),
                          child: Text('50\$', style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600)),
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
          right: 8,
          top: 6,

          child: InkWell(
            child: Icon(Icons.close, color: Colors.red),
          ),
        ),
      ],
    );
  }

  getColor() {
    return Get.isDarkMode ? Colors.white : Colors.black;
  }
}
