import 'package:get/get.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';

import '../../../routes/app_routes.dart';

class FirstSplashController extends GetxController {
  RxDouble opacity = 0.0001.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 1));
    opacity.value = 0.9;
    await Future.delayed(const Duration(seconds: 5), () {
      firstTime();
    });
  }

  void firstTime() {
    final isContains = Get.find<AuthService>().stroge.containsKey('one-Time');
    if (isContains) {
      if (Get.find<AuthService>().isAuth()) {
        Get.rootDelegate.offNamed(Paths.HOME);
      } else {
        Get.rootDelegate.offNamed(Paths.LogIn);
      }
    } else {
      Get.find<AuthService>().stroge.saveData('one-Time', 'saved');
      Get.rootDelegate.offNamed(Paths.Intro);
    }
  }

  @override
  void onClose() {}
}
