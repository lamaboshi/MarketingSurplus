import 'package:get/get.dart';
import 'package:marketing_surplus/modules/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
