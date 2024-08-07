import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/setting_profile/controller/setting_profile_controller.dart';

import '../../../../../shared/widgets/empty_screen.dart';

class CompanyUsersPage extends GetView<SettingProfileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'user-sub'.tr,
              style: TextStyle(
                  fontSize: 21,
                  color: Colors.purple.shade200,
                  fontWeight: FontWeight.bold),
            ),
          ),
          controller.companyUsers.isEmpty
              ? EmptyData()
              : Column(
                  children: controller.companyUsers
                      .map((element) => ListTile(
                            title: Text(element.name ?? ''),
                          ))
                      .toList()),
          SizedBox(height: 15)
        ])));
  }
}
