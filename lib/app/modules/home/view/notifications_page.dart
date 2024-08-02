import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/home/controller/home_controller.dart';
import 'package:marketing_surplus/shared/widgets/empty_screen.dart';

import '../../../../shared/date_extation.dart';
import '../../../../shared/service/auth_service.dart';

class NotificationsPage extends GetView<HomeController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => getEmpty()
        ? const EmptyData()
        : Column(
            children: controller.auth.getTypeEnum() == Auth.user
                ? controller.allUserNotification
                    .map((element) => getListTitle(
                        type: element.type ?? '',
                        message: element.message ?? '',
                        time: getFormattedDate(element.createdAt!),
                        isRead: element.isRead!))
                    .toList()
                : controller.allCharityNotification
                    .map((element) => getListTitle(
                        type: element.type ?? '',
                        message: element.message ?? '',
                        time: getFormattedDate(element.createdAt!),
                        isRead: element.isRead!))
                    .toList(),
          ));
  }

  bool getEmpty() => controller.auth.getTypeEnum() == Auth.user
      ? controller.allUserNotification.isEmpty
      : controller.allCharityNotification.isEmpty;

  Widget getListTitle(
      {required String type,
      required String time,
      required String message,
      required bool isRead}) {
    return ListTile(
      title: Text(type),
      trailing: isRead
          ? SizedBox.shrink()
          : Icon(
              Icons.circle,
              color: Colors.red,
            ),
      subtitle: Column(
        children: [
          Text(message),
          Text(time),
        ],
      ),
    );
  }
}
