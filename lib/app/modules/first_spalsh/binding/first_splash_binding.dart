import 'package:get/get.dart';

import '../controller/first_splash_page.dart';

class FirstSplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FirstSplashController());
  }
}
