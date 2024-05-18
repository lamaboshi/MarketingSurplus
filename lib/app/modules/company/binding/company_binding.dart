import 'package:get/get.dart';

import '../controller/company_controller.dart';

class CompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CompanyController());
  }
}
