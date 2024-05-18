import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';

class BillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BillsController());
  }
}
