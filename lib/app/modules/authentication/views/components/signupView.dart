import 'dart:io';

import 'package:eshop/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:eshop/app/modules/authentication/utility/validator.dart';
import 'package:eshop/app/modules/authentication/views/components/loginView.dart';
import 'package:eshop/app/modules/authentication/views/components/passwordField.dart';
import 'package:eshop/app/modules/authentication/views/components/textInput.dart';
import 'package:eshop/app/routes/app_pages.dart';
import 'package:eshop/app/values/appColors.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'facebookAuthBTN.dart';
import 'googleAuthBTN.dart';
import 'inputBoxWidget.dart';

class SignUpView extends GetWidget<AuthenticationController> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.visibility.value = true;
        return  true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: context.height,
                padding: EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style: context.textTheme.headline1,
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 3,
                              color: Get.isDarkMode
                                  ? AppColors.white
                                  : AppColors.blackDark),
                        ),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100000),
                          child: InkWell(
                            child: Obx(()=>controller.image.value != ''? Image.file(File(controller.image.value),fit: BoxFit.cover,): buildNoImageWidget()),
                            onTap: () => controller.chooseImageSource(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        InputBoxWidget(
                          child: TextInputField(
                            label: "Name",
                            validator: (value) => Validator.nameValidate(value),
                            hintText: "Your Name",
                            controller: _name,
                            inputType: TextInputType.name,
                          ),
                        ),
                        SizedBox(height: 10),
                        InputBoxWidget(
                          child: TextInputField(
                            validator: (value) => Validator.emailValidate(value),
                            controller: _email,
                            label: "Email",
                            hintText: "your@email.com",
                            inputType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(height: 10),
                        InputBoxWidget(
                          child: PasswordField(
                            passCNT: _password,
                            validator: (value) => Validator.passValidate(value),
                            label: "Password",
                            hintText: "Password",
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            child: Text("Already have an account?",
                                style: context.textTheme.subtitle1),
                            onPressed: () => Get.to(() => LoginView()),
                          ),
                        ),
                        SizedBox(height: 20),
                        Obx(() => controller.isRequesting.value
                            ? CircularProgressIndicator()
                            : buildSignUpButton(context)),
                        SizedBox(height: 30),
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                            child: Text(
                          'Or sing up with social account',
                          style: context.textTheme.subtitle1,
                        )),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoogleAuthButton(onPressed: () {
                              print('Check');
                              print(FirebaseAuth.instance.currentUser);
                            }),
                            SizedBox(width: 16),
                            FaceBookAuthButton(onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Icon buildNoImageWidget() => Icon(Icons.person_outlined,
      size: 40, color: Get.isDarkMode ? AppColors.white : AppColors.blackDark);

  MaterialButton buildSignUpButton(BuildContext context) {
    return MaterialButton(
      height: 48,
      minWidth: context.width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      color: AppColors.primary,
      child: Text('Sing Up',
          style: context.textTheme.subtitle1?.copyWith(color: Colors.white)),
      onPressed: () async{
        if (_formKey.currentState!.validate()) {
          final result = await controller.signUp(
              _email.text.trim(), _password.text.trim(), _name.text.trim());
          if(result) {
            Get.offAllNamed(Routes.HOME);
            print("Successfully signup");
          }
        }
      },
    );
  }
}
