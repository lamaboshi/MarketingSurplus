import 'package:get/get.dart';

import '../../../../api/storge/storge_service.dart';
import '../../../../shared/service/auth_service.dart';
import '../../../routes/app_routes.dart';

class LogInController extends GetxController {
  String? forceValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'requird';
    }
    return null;
  }

  final email = ''.obs;
  final password = ''.obs;
  final authService = Get.find<AuthService>();
  final stroge = Get.find<StorageService>();

  Future<void> logIn() async {
    await authService.logIn(email.value, password.value);
    if (!stroge.containsKey('type')) {
      return;
    }
    Get.rootDelegate.offNamed(Paths.HOME);
  }
}
