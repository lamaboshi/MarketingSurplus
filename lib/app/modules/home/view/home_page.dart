import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.pageList[controller.pageIndex.value],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.pageIndex.value,
            selectedItemColor: Colors.purple,
            selectedFontSize: 14,
            unselectedItemColor: Colors.grey,
            unselectedFontSize: 12,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: (index) async {
              controller.pageIndex.value = index;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30.0),
                label: "الرئيسية",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant_menu, size: 30.0),
                  label: 'العروض'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, size: 30.0), label: 'المفضلة'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 30.0), label: 'حسابي'),
            ]),
      ),
    );
  }
}
