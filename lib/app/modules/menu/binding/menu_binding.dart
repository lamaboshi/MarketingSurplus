import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/menu/controller/menu_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MenuController());
  }
}
