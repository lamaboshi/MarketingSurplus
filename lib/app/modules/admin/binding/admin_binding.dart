import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/admin/controller/admin_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdminController());
  }
}
