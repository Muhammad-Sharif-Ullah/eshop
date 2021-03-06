import 'package:eshop/app/components/avatar_widget.dart';
import 'package:eshop/app/modules/home/controllers/home_controller.dart';
import 'package:eshop/app/modules/home/views/beg/views/payment_view.dart';
import 'package:eshop/app/modules/home/views/beg/views/shipping_view.dart';
import 'package:eshop/app/modules/home/views/profile/views/settings_view.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'my_order_view.dart';
import 'my_reviews_view.dart';

class ProfileView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(AppConstant.kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Profile',
                  style: context.textTheme.headline1,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    GetX(
                      builder: (HomeController cnt) {
                        if (cnt.user.value == null)
                          return Container(
                            padding: const EdgeInsets.all(4),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.greenAccent, width: 3),
                            ),
                          );
                        return AvatarWidget(
                            url: cnt.user.value!.photoURL!, radius: 60);
                      },
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GetX(builder: (HomeController cnt) {
                          if (cnt.user.value == null) return Text('Loading');
                          return Text('${cnt.user.value!.displayName}',
                              style: context.textTheme.headline3?.copyWith(
                                  letterSpacing: -.1, wordSpacing: -1));
                        }),
                        GetX(builder: (HomeController cnt) {
                          if (cnt.user.value == null) return Text('Loading');
                          return Text(cnt.user.value!.email!,
                              style: context.textTheme.bodyText2?.copyWith(
                                  color: Colors.grey,
                                  letterSpacing: -.1,
                                  fontWeight: FontWeight.w600));
                        }),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 28),
                buildContent(
                  context,
                  title: 'My Order',
                  text: 'Already have 12 orders',
                  onTap: () => Get.to(() => MyOrderView()),
                ),
                buildContent(
                  context,
                  title: 'Shipping Address',
                  text: '3 Address',
                  onTap: () => Get.to(() => ShippingView()),
                ),
                buildContent(
                  context,
                  title: 'Payment Method',
                  text: 'Visa **34',
                  onTap: () => Get.to(() => PaymentView()),
                ),
                buildContent(
                  context,
                  title: 'Promo Codes',
                  text: 'You have special promo-codes',
                  onTap: () {},
                ),
                buildContent(
                  context,
                  title: 'My Reviews',
                  text: 'Review for 4 items',
                  onTap: () => Get.to(() => MyReviewsView()),
                ),
                buildContent(
                  context,
                  title: 'Settings',
                  text: 'Notification and Password',
                  onTap: () => Get.to(() => SettingsView()),
                ),
                // onTap: () async {
                //   await FireBaseAuth.logOut();
                //   Get.offAllNamed(Routes.AUTHENTICATION);
                // },),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile buildContent(BuildContext context, {title, text, onTap}) {
    return ListTile(
      title: Text(
        title,
        style: context.textTheme.subtitle2,
      ),
      subtitle: Text(text,
          style: context.textTheme.bodyText1?.copyWith(
              fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey)),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
      contentPadding: const EdgeInsets.all(3.0),
    );
  }
}
