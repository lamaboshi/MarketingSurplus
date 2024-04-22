import 'package:get/get.dart';

import '../controller/log_in_controller.dart';

class LogInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LogInController());
  }
}
