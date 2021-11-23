import 'package:eshop/app/components/bigSplashButton.dart';
import 'package:eshop/app/components/normalInputField.dart';
import 'package:eshop/app/controllers/account_service_controller.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingEditView extends StatefulWidget {
  const ShippingEditView({Key? key}) : super(key: key);

  @override
  _ShippingEditViewState createState() => _ShippingEditViewState();
}

class _ShippingEditViewState extends State<ShippingEditView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _zip = TextEditingController();
  final controller = Get.find<AccountServiceController>();
  final RxBool btnDisable = false.obs;
  final RxBool isActive = false.obs;

  @override
  void initState() {
    if (Get.arguments != null) {
      final args = Get.arguments;
      _name.text = args.name;
      _address.text = args.address;
      _city.text = args.city;
      _zip.text = args.zip;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onSubmit() async {
      if (_formKey.currentState!.validate()) {
        final result = await controller.addAddress(
            _name.text, _address.text, _city.text, _zip.text, isActive.value);
        if (result) {
          Get.rawSnackbar(
            messageText: Center(child: Text("Done")),
            backgroundColor: AppColors.success.withOpacity(.2),
            duration: Duration(milliseconds: 1000),
          );
          controller.isRequesting.toggle();
          btnDisable.value = true;
          Future.delayed(Duration(milliseconds: 2000), () {}).then((value) {
            // dispose();
            Get.back();
          });
        } else {
          Get.rawSnackbar(
              message: "Somethign wrong try again",
              backgroundColor: Colors.red.shade200);
          controller.isRequesting.toggle();
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Shopping Address",
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          // dispose();

          return true;
        },
        child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    NormalInputField(
                      textController: _name,
                      label: "Name",
                      inputType: TextInputType.text,
                      hintText: "Address holder name",
                      validator: (String? value) {
                        if (value!.trim().isEmpty)
                          return "Name could not be empty";
                        else if (value.trim().length < 6)
                          return "Name should be at least 6 characters";
                        else if (value.trim().length >= 50)
                          return "Name should not be more than 50 characters";
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    NormalInputField(
                      textController: _address,
                      label: "Address",
                      inputType: TextInputType.text,
                      hintText: "Type complete adddress",
                      validator: (String? value) {
                        if (value!.trim().isEmpty)
                          return "Address could not be empty";
                        else if (value.trim().length < 10)
                          return "Address should be at least 10 character";
                        else if (value.trim().length > 400)
                          return "Address should not be more than 4000 character";
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    NormalInputField(
                      textController: _city,
                      label: "City",
                      inputType: TextInputType.text,
                      hintText: "City name",
                      validator: (String? value) {
                        if (value!.trim().isEmpty)
                          return "City could not be empty";
                        else if (value.trim().length > 50)
                          return "City should not be more than 4000 character";
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    NormalInputField(
                      textController: _zip,
                      label: "Zip-Code",
                      inputType: TextInputType.number,
                      hintText: "e.g: 1234",
                      validator: (String? value) {
                        if (value!.trim().isEmpty)
                          return "Zip-Code could not be empty";
                        else if (!value.trim().isNumericOnly)
                          return "Zip-Code must be digits not other character";
                        else if (value.trim().length > 4)
                          return "Address should be 4 digits";
                        return null;
                      },
                    ),
                    SizedBox(height: 14),
                    // Obx(() => CheckboxListTile(
                    //       title: Text(
                    //         "Use as default the shipping address",
                    //         style: context.textTheme.caption
                    //             ?.copyWith(fontWeight: FontWeight.normal),
                    //       ),
                    //       controlAffinity: ListTileControlAffinity.leading,
                    //       contentPadding: EdgeInsets.zero,
                    //       value: isActive.value ? true : false,
                    //       activeColor:
                    //           context.isDarkMode ? Colors.white : Colors.black,
                    //       checkColor:
                    //           !context.isDarkMode ? Colors.white : Colors.black,
                    //       onChanged: (newValue) => isActive.toggle(),
                    //     )),
                    SizedBox(height: 40),
                    Obx(
                      () => controller.isRequesting.value
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(AppColors.primary),
                            )
                          : btnDisable.value
                              ? Container()
                              : BigSplashButton(
                                  height: 48,
                                  width: context.width,
                                  text: "Submit",
                                  onPressed: onSubmit,
                                ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
