import 'dart:ui';

import 'package:get/get.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';

class IntroController extends GetxController {
  final isChecked = false.obs;
  final isEn = false.obs;
  final listTextTabToggle = ["عربي", "English"];
  final auth = Get.find<AuthService>();
  RxInt tabTextIndexSelected = 0.obs;

  void toggle(int index) {
    tabTextIndexSelected.value = index;
    if (index == 0) {
      Get.updateLocale(Locale('ar', 'AR'));
    } else {
      Get.updateLocale(Locale('en', 'EN'));
    }
    if (auth.stroge.containsKey('Local')) {
      auth.stroge.deleteDataByKey('Local');
    }
    auth.stroge.saveData('Local', index == 0 ? 'ar' : 'en');
  }
}
