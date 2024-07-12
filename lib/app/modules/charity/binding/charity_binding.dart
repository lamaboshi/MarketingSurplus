import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/charity/controller/charity_controller.dart';

class CharityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CharityController());
  }
}
