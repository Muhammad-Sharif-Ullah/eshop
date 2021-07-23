import 'package:eshop/app/modules/authentication/views/components/loginView.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  @override
  Widget build(BuildContext context) {
    return LoginView();
  }
}
