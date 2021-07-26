import 'package:eshop/app/components/bigSplashButton.dart';
import 'package:eshop/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:eshop/app/modules/authentication/utility/validator.dart';
import 'package:eshop/app/modules/authentication/views/components/forgotPassView.dart';
import 'package:eshop/app/modules/authentication/views/components/passwordField.dart';
import 'package:eshop/app/modules/authentication/views/components/signupView.dart';
import 'package:eshop/app/modules/authentication/views/components/textInput.dart';
import 'package:eshop/app/routes/app_pages.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'facebookAuthBTN.dart';
import 'googleAuthBTN.dart';
import 'inputBoxWidget.dart';

class LoginView extends GetWidget<AuthenticationController> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: context.textTheme.headline1,
                    ),
                    Column(
                      children: [
                        InputBoxWidget(
                          child: TextInputField(
                            controller: _email,
                            validator: (value) => Validator.emailValidate(value),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            child: Text("Forgot Password",
                                style: context.textTheme.subtitle1),
                            onPressed: () => Get.to(() => ForgotPassView()),
                          ),
                        ),
                        SizedBox(height: 32),
                        buildLoginButton(context),
                        SizedBox(height: 16),
                        Center(
                          child: TextButton(
                            child: Text("Don't have a account?",
                                style: context.textTheme.subtitle1),
                            onPressed: () => Get.to(() => SignUpView()),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                            child: Text(
                          'Or login with social account',
                          style: context.textTheme.subtitle1,
                        )),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoogleAuthButton(onPressed: () {}),
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

  Widget buildLoginButton(BuildContext context) {
    return Obx(() => controller.isRequesting.value
        ? CircularProgressIndicator()
        : BigSplashButton(
            width: context.width,
            height: 48,
            text: "Login",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final result = await controller.login(_email.text.trim(), _password.text.trim());
                if(result){
                  Get.offAllNamed(Routes.HOME);
                  print("Successfully login");
                }
              }
            },
          ));
  }
}
