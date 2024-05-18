import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/intro/controller/intro_controller.dart';

class IntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(IntroController());
  }
}
