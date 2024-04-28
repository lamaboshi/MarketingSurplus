import 'package:get/get.dart';

import '../controller/passowd_controller.dart';

class PasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PasswordController());
  }
}
