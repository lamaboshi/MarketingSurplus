import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/home/controller/home_controller.dart';
import 'package:marketing_surplus/app/modules/menu/controller/menu_controller.dart';

import '../../../../api/storge/storge_service.dart';
import '../../../../shared/service/auth_service.dart';
import '../../../routes/app_routes.dart';

class LogInController extends GetxController {
  final passwordVisible = false.obs;
  final isLoading = false.obs;
  final userPasswordController = TextEditingController();
  String? forceValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'requird';
    }
    return null;
  }

  final userForm = GlobalKey<FormState>();
  final email = ''.obs;
  final password = ''.obs;
  final authService = Get.find<AuthService>();
  final stroge = Get.find<StorageService>();

  Future<void> logIn() async {
    isLoading.value = true;
    await authService.logIn(email.value, password.value);
    if (!stroge.containsKey('type')) {
      isLoading.value = false;
      return;
    }
    isLoading.value = false;
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().onInit();
    }
    if (Get.isRegistered<MenuController>()) {
      Get.find<MenuController>().onInit();
    }
    Get.rootDelegate.history.clear();
    Get.rootDelegate.offAndToNamed(Paths.HOME);
  }
}
