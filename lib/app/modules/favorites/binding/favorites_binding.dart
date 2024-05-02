import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/favorites/controller/favorites_controller.dart';

class FavoritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoritesController());
  }
}
