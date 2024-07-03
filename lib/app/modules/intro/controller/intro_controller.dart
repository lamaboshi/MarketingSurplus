import 'dart:ui';

import 'package:get/get.dart';

class IntroController extends GetxController {
  final isChecked = false.obs;
  final isEn = false.obs;
  final listTextTabToggle = ["عربي", "English"];

  RxInt tabTextIndexSelected = 0.obs;

  void toggle(int index) {
    tabTextIndexSelected.value = index;
    if (index == 0) {
      Get.updateLocale(Locale('ar', 'AR'));
    } else {
      Get.updateLocale(Locale('en', 'EN'));
    }
  }
}
