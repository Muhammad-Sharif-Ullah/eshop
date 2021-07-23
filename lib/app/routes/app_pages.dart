import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:eshop/app/modules/authentication/bindings/authentication_binding.dart';
import 'package:eshop/app/modules/authentication/views/authentication_view.dart';
import 'package:eshop/app/modules/home/bindings/home_binding.dart';
import 'package:eshop/app/modules/home/views/home_view.dart';
import 'package:eshop/app/modules/product_details/bindings/product_details_binding.dart';
import 'package:eshop/app/modules/product_details/views/product_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: non_constant_identifier_names
  static final INITIAL = FirebaseAuth.instance.currentUser !=null ? Routes.HOME :Routes.AUTHENTICATION;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
  ];
}
