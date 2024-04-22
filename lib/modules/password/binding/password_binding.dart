import 'package:get/get.dart';
import 'package:marketing_surplus/modules/password/controller/passowd_controller.dart';

class PasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PasswordController());
  }
}
