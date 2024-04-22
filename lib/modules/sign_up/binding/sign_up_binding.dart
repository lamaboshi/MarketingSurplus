import 'package:get/get.dart';
import 'package:marketing_surplus/modules/sign_up/controller/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
  }
}
