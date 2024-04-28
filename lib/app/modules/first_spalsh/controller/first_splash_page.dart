import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class FirstSplashController extends GetxController {
  RxDouble opacity = 0.0001.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 1));
    opacity.value = 0.9;
    await Future.delayed(const Duration(seconds: 5), () {
      Get.rootDelegate.offNamed(Paths.Intro);
    });
  }

  @override
  void onClose() {}
}
