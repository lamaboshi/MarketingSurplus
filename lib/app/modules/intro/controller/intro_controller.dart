import 'package:get/get.dart';

class IntroController extends GetxController {
  final isChecked = false.obs;
  final isEn = false.obs;
  final listTextTabToggle = ["عربي", "English"];

  RxInt tabTextIndexSelected = 0.obs;

  toggle(int index) => tabTextIndexSelected.value = index;
}
