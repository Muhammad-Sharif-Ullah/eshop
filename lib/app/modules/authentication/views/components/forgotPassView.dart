

import 'package:eshop/app/components/bigSplashButton.dart';
import 'package:eshop/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:eshop/app/modules/authentication/utility/validator.dart';
import 'package:eshop/app/modules/authentication/views/components/passwordField.dart';
import 'package:eshop/app/modules/authentication/views/components/textInput.dart';
import 'package:eshop/app/values/appConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'inputBoxWidget.dart';
class ForgotPassView extends GetWidget<AuthenticationController> {
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48),
                Text(
                  "Forgot password",
                  style: context.textTheme.headline1,
                ),
                Spacer(),
                Column(
                  children: [
                    Text('Enter your email address. You will receive a link to create a new password via email',style: Theme.of(context).textTheme.bodyText2,),
                    SizedBox(height: 20),
                    InputBoxWidget(
                      child: TextInputField(
                        controller: _email,
                        validator: (value) => Validator.emailValidate(value),
                        label: "Email",
                        hintText: "your@email.com",
                        inputType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 32),
                    BigSplashButton(
                      width: context.width,
                      height: 48,
                      text: "SEND",
                      onPressed: () {
                        // print(_formKey.currentState!.validate());
                        if (_formKey.currentState!.validate())
                          print("Ok");
                        else
                          print('NOt Ok');
                      },
                    ),
                    SizedBox(height: 16),
                  ],
                ),
                Spacer(),

              ],
            ),
          ),
        ),
      ),
    );

  }
}

