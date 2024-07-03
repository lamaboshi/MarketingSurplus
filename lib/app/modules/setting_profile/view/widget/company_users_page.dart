import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/setting_profile/controller/setting_profile_controller.dart';

class CompanyUsersPage extends GetView<SettingProfileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        children: controller.companyUsers
            .map((element) => ListTile(
                  title: Text(element.name ?? ''),
                ))
            .toList()));
  }
}
