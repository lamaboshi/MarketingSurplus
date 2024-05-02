import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/product/controller/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
  }
}
