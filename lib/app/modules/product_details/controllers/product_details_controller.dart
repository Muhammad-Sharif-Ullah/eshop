import 'package:eshop/app/model/product_model.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {

  final ProductModel product = Get.arguments;

  final RxString color = RxString('');
  final RxString size = RxString('');

  @override
  void onInit() {
    super.onInit();
    color.value = product.colors![0];
    size.value = product.sizes![0];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
