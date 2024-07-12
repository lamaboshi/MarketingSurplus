import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';

import '../../../../shared/widgets/empty_screen.dart';

class BillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BillsController());
    Get.put(EmptyBasketController());
  }
}
