import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/firebase_repository/firebase_auth.dart';
import 'package:eshop/app/modules/authentication/utility/validator.dart';
import 'package:eshop/app/modules/authentication/views/components/passwordField.dart';
import 'package:eshop/app/modules/home/controllers/home_controller.dart';
import 'package:eshop/app/routes/app_pages.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

class SettingsView extends GetView<AccountServiceController> {
  @override
  Widget build(BuildContext context) {
    Rx<DateTime> newDOB = DateTime.now().obs;
    Rx<DateTime> oldDOB = DateTime.now().obs;
    final inputFormat = DateFormat('dd/MM/yyyy');

    getFormatDOB() => inputFormat.format(newDOB.value);
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        // title: Text('SettingsView'),
        // iconTheme: IconThemeData(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(AppConstant.kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: context.textTheme.headline1,
                ),
                SizedBox(height: 20),
                Text(
                  'Personal Information',
                  style: context.textTheme.headline3,
                ),
                SizedBox(height: 28),
                SettingCard(
                    height: 74,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Full Name",
                            style: context.textTheme.caption?.copyWith(
                                color: Colors.grey,
                                wordSpacing: 0,
                                fontWeight: FontWeight.bold)),
                        GetX(builder: (HomeController cnt) {
                          if (cnt.user.value == null) return Text('Loading');
                          return Text('${cnt.user.value!.displayName}',
                              style: context.textTheme.caption);
                        }),
                      ],
                    )),
                SizedBox(height: 10),
                InkWell(
                  onTap: () => changeDOB(newDOB, oldDOB),
                  child: SettingCard(
                      height: 64,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date Of Birth",
                              style: context.textTheme.caption?.copyWith(
                                  color: Colors.grey,
                                  wordSpacing: 0,
                                  fontWeight: FontWeight.bold)),
                          Obx(() => Text(getFormatDOB().toString()))
                        ],
                      )),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Password',
                        style: context.textTheme.headline3,
                      ),
                      TextButton(
                          onPressed: () {
                            changePassword(context);
                          },
                          child: Text("Change",
                              style: TextStyle(color: Colors.grey))),
                    ],
                  ),
                ),
                SettingCard(
                    height: 64,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Password",
                            style: context.textTheme.caption?.copyWith(
                                color: Colors.grey,
                                wordSpacing: 0,
                                fontWeight: FontWeight.bold)),
                        Text("******************")
                      ],
                    )),
                SizedBox(height: 30),
                Text(
                  'Notifications',
                  style: context.textTheme.headline3,
                ),
                buildSwitchButton("Sale", controller.sale, context),
                buildSwitchButton(
                    "New Arrivals", controller.newArrivals, context),
                buildSwitchButton("Delivery Status Change",
                    controller.deliveryStatus, context),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: context.width * .5,
                    child: ElevatedButton.icon(
                        onPressed: () async {
                          await FireBaseAuth.logOut();
                          Get.offAllNamed(Routes.AUTHENTICATION);
                        },
                        icon: Icon(Icons.logout),
                        label: Text("Logout")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> changePassword(BuildContext context) {
    TextEditingController oldPASS = TextEditingController();
    TextEditingController newPAss = TextEditingController();
    return Get.bottomSheet(
      Container(
        color: Colors.white,
        height: context.height,
        child: Column(
          children: [
            Expanded(
              child: PasswordField(
                  label: 'Old Password',
                  hintText: "********",
                  passCNT: oldPASS,
                  validator: (String? value) => Validator.passValidate(value)),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> changeDOB(Rx<DateTime> newDOB, Rx<DateTime> oldDOB) {
    return Get.defaultDialog(
        backgroundColor: Get.isDarkMode ? AppColors.blackDark : AppColors.white,
        title: "Select Date Of Birth",
        titleStyle: TextStyle(
            color: !Get.isDarkMode ? AppColors.blackDark : AppColors.white),
        confirm: ElevatedButton(
            onPressed: () {
              //TODO: Changing Code with Backend
              newDOB.value = oldDOB.value;
              Get.back();
            },
            child: Text("Change Now"),
            style: ElevatedButton.styleFrom(primary: AppColors.success)),
        cancel:
            ElevatedButton(onPressed: () => Get.back(), child: Text("Cancel")),
        content: Container(
          color: Colors.white,
          height: 300,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            child: CupertinoDatePicker(
              backgroundColor:
                  Get.isDarkMode ? AppColors.blackDark : AppColors.white,
              mode: CupertinoDatePickerMode.date,
              initialDateTime: newDOB.value,
              onDateTimeChanged: (DateTime newDateTime) {
                oldDOB.value = newDateTime;
              },
            ),
          ),
        ));
  }

  ListTile buildSwitchButton(
      String btnName, RxBool onActive, BuildContext context) {
    return ListTile(
      leading: Text(btnName, style: context.textTheme.subtitle2),
      trailing: Obx(() => CupertinoSwitch(
            value: onActive.value,
            onChanged: (value) => onActive.toggle(),
          )),
    );
  }
}

class SettingCard extends StatelessWidget {
  const SettingCard({
    Key? key,
    this.height = 64,
    required this.child,
  }) : super(key: key);
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Get.isDarkMode ? AppColors.blackDark : AppColors.white,
      child: Container(
        height: height,
        padding: const EdgeInsets.only(left: 14.0),
        alignment: Alignment.centerLeft,
        width: context.width,
        child: child,
      ),
    );
  }
}
