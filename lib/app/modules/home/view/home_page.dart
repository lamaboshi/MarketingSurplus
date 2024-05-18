import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';
import 'package:marketing_surplus/shared/widgets/auth_bottom_sheet.dart';

import '../../../routes/app_routes.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          actions: [
            controller.pageIndex.value == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Obx(
                        () => DropdownButton<String>(
                          focusNode: FocusNode(),
                          underline: const SizedBox(),
                          hint: const Text('Select Company'),
                          value: controller.isAll.value
                              ? controller.select.first
                              : controller.select.last,
                          onChanged: (newValue) async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (!controller.auth.isAuth()) {
                              await AuthBottomSheet().modalBottomSheet(context);
                            } else {
                              controller.select.indexOf(newValue!) == 0
                                  ? controller.isAll.value = true
                                  : controller.isAll.value = false;
                              await controller.getPosts();
                            }
                          },
                          items: controller.select.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            controller.pageIndex.value == 3
                ? Padding(
                    padding: const EdgeInsets.all(5),
                    child: IconButton(
                        onPressed: () async {
                          if (!controller.auth.isAuth()) {
                            await AuthBottomSheet().modalBottomSheet(context);
                          } else {
                            await Get.rootDelegate
                                .toNamed(Paths.SettingProfile);
                          }
                        },
                        icon: Icon(
                          Icons.settings,
                          color: Colors.purple.shade200,
                        )),
                  )
                : const SizedBox.shrink()
          ],
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(40))),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Clout',
                style: TextStyle(
                    color: Colors.purple.shade200,
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
            ],
          ),
        ),
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
              if (index == 2) {
                Get.find<BillsController>().onInit();
              }
              controller.pageIndex.value = index;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30.0),
                label: "الرئيسية",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant_menu, size: 30.0),
                  label: 'حديثا'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopify_sharp, size: 30.0), label: 'السلة'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 30.0), label: 'حسابي'),
            ]),
      ),
    );
  }
}
