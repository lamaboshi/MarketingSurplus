import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../api/storge/storge_service.dart';
import '../../../../shared/service/auth_service.dart';
import '../../../routes/app_routes.dart';
import '../data/password_repo.dart';
import '../model/rest_password.dart';
import '../view/confirm_passwod.dart';

class PasswordController extends GetxController {
  final repo = PasswordRepository();
  final resrtpassword = ''.obs;
  final password = ''.obs;
  final email = ''.obs;
  final restModel = RestPassword().obs;
  final authService = Get.find<AuthService>();
  final stroge = Get.find<StorageService>();
  Future<void> getEmail() async {
    var data = await repo.getEmail(email.value);
    if (data != null) {
      restModel.value = data;
      Get.to(() => const Confirmpassword());
    }
  }

  Future<void> resetPassword() async {
    final result = false.obs;
    switch (restModel.value.type) {
      case 'user':
        result.value =
            await repo.resetPassUser(restModel.value.id!, password.value);
        break;
      case 'comapny':
        result.value =
            await repo.resetPassComp(restModel.value.id!, password.value);
        break;
    }
    if (result.value) {
      await authService.logIn(email.value, password.value);
      if (!stroge.containsKey('type')) {
        return;
      }
      await OverPanel(
              alignment: Alignment.bottomCenter,
              height: 120,
              child: Row(
                children: [
                  Icon(
                    Icons.admin_panel_settings_sharp,
                    color: Colors.purple.shade200,
                  ),
                  const Text(
                    ' Saved New Password',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              duration: const Duration(seconds: 2))
          .show();
      Get.rootDelegate.offNamed(Paths.HOME);
    }
  }
}
