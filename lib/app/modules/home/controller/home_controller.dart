import 'package:get/get.dart';

import '../../favorites/view/favorites_page.dart';
import '../../menu/view/menu_page.dart';
import '../../profile/view/profile_page.dart';
import '../view/main_page.dart';

class HomeController extends GetxController {
  final pageIndex = 1.obs;

  final pageList = [
    MainView(),
    MenView(),
    const FavoritesView(),
    const ProfileView()
  ];
}
