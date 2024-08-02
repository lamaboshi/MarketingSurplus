import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';
import 'package:marketing_surplus/app/modules/home/view/notifications_page.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';
import 'package:marketing_surplus/shared/widgets/auth_bottom_sheet.dart';
import 'package:overlayment/overlayment.dart';

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
            Obx(
              () => controller.pageIndex.value == 0 &&
                      controller.auth.getTypeEnum() == Auth.user
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(
                          () => DropdownButton<String>(
                            focusNode: FocusNode(),
                            underline: const SizedBox(),
                            hint: Text('selectcomp-title'.tr),
                            value: controller.isAll.value
                                ? controller.select.first
                                : controller.select.last,
                            onChanged: (newValue) async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (!controller.auth.isAuth()) {
                                await AuthBottomSheet()
                                    .modalBottomSheet(context);
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
                                child: Text(e.tr),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
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
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(5),
              child: IconButton(
                  onPressed: () async {
                    Overlayment.show(OverPanel(
                        alignment: Alignment.centerLeft,
                        child: NotificationsPage()));
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.purple.shade200,
                  )),
            )
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
        body: RefreshIndicator(
          onRefresh: () async {
            controller.onInit();
          },
          child: Obx(
            () => controller.auth.getTypeEnum() == Auth.user
                ? controller.pageList[controller.pageIndex.value]
                : controller.auth.getTypeEnum() == Auth.comapny
                    ? controller.pageListCompany[controller.pageIndex.value]
                    : controller.pageList[controller.pageIndex.value],
          ),
        ),
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
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home, size: 30.0),
                label: "main-title".tr,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant_menu, size: 30.0),
                  label: 'newly-title'.tr),
              BottomNavigationBarItem(
                  icon: Icon(
                      controller.auth.getTypeEnum() == Auth.comapny
                          ? Icons.cabin_sharp
                          : Icons.shopping_cart,
                      size: 30.0),
                  label: controller.auth.getTypeEnum() == Auth.comapny
                      ? 'asso-title'.tr
                      : 'bas-title'.tr),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 30.0), label: 'account'.tr),
            ]),
      ),
    );
  }
}
