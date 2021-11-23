import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/model/shipping_model.dart';
import 'package:eshop/app/modules/home/views/beg/views/shipping_edit.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingView extends GetWidget<AccountServiceController> {
  const ShippingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getColor(isActive) {
      return isActive
          ? AppColors.success.withOpacity(0.8)
          : (Get.isDarkMode ? AppColors.blackDark : AppColors.backgroundLight);
    }

    RxString activeID = "".obs;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shipping Addresses",
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        centerTitle: true,
      ),
      // ignore: deprecated_member_use
      body: StreamBuilder<List<ShippingModel>>(
          stream: controller.shippingAddresssStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: Text("Loading"));
            else if (snapshot.hasError)
              return Center(child: Text("${snapshot.error}"));
            else if (snapshot.data!.isEmpty)
              return Center(child: Text("Please add your shipping address"));
            return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final ShippingModel address = snapshot.data![index];
                  if (address.isActive) activeID.value = address.id;
                  // else
                  //   activeID.value = '';
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      color: getColor(address.isActive),
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstant.kPadding),
                        child: Stack(
                          children: [
                            Container(
                              width: context.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(address.name),
                                  Text(address.address),
                                  Text(
                                      "City: ${address.city}, Zip: ${address.zip}"),
                                  CheckboxListTile(
                                    title: Text(
                                      "Use as the shipping address",
                                      style: context.textTheme.caption
                                          ?.copyWith(
                                              fontWeight: FontWeight.normal),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    value: address.isActive,
                                    activeColor: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    checkColor: !context.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    onChanged: (newValue) {
                                      // if (activeID.value == address.id)
                                      //   activeID.value = '';
                                      controller.makeActive(activeID.value,
                                          address.id, address.isActive);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: -14,
                              right: -15,
                              child: PopupMenuButton(
                                onSelected: (value) {
                                  if (value == 'edit')
                                    Get.to(() => ShippingEditView(),
                                        arguments: address);
                                  else
                                    print('delete');
                                },
                                itemBuilder: (context) =>
                                    <PopupMenuItem<String>>[
                                  PopupMenuItem(
                                    child: Text('Edit'),
                                    value: "edit",
                                  ),
                                  PopupMenuItem(
                                      child: Text('Delete'), value: "delete"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => ShippingEditView()),
        elevation: 10,
        backgroundColor: context.isDarkMode ? Colors.white : Colors.black,
        child: Icon(Icons.add,
            color: !context.isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}
