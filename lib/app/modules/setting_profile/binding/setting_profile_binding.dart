import 'package:get/get.dart';

import '../controller/setting_profile_controller.dart';

class SettingProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingProfileController());
  }
}
