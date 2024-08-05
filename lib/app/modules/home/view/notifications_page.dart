import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/home/controller/home_controller.dart';
import 'package:marketing_surplus/shared/widgets/empty_screen.dart';

import '../../../../shared/date_extation.dart';
import '../../../../shared/service/auth_service.dart';

class NotificationsPage extends GetView<HomeController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getNotification();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'NotificationsPage',
              style: TextStyle(color: Colors.purple.shade200, fontSize: 19),
            ),
            Obx(() => getEmpty()
                ? const EmptyData()
                : Column(
                    children: controller.auth.getTypeEnum() == Auth.user
                        ? controller.allUserNotification
                            .where((p0) => !p0.type!.contains('User'))
                            .map((element) => getListTitle(
                                id: element.id!,
                                type: element.type ?? '',
                                message: element.message ?? '',
                                time: getFormattedDate(element.createdAt!),
                                isRead: element.isRead!,
                                fromUser: null))
                            .toList()
                        : controller.auth.getTypeEnum() == Auth.charity
                            ? controller.allCharityNotification
                                .where((p0) => !p0.type!.contains('Charity'))
                                .map((element) => getListTitle(
                                    id: element.id!,
                                    type: element.type ?? '',
                                    message: element.message ?? '',
                                    time: getFormattedDate(element.createdAt!),
                                    isRead: element.isRead!,
                                    fromUser: null))
                                .toList()
                            : [
                                SizedBox(
                                  height: Get.height - 100,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Obx(
                                          () => SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  ' User NotificationsPage',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .purple.shade200,
                                                      fontSize: 19),
                                                ),
                                                SingleChildScrollView(
                                                  child: Column(
                                                      children: controller
                                                          .allUserNotification
                                                          .where((p0) =>
                                                              !p0.type!.contains(
                                                                  'Company'))
                                                          .map((element) => getListTitle(
                                                              id: element.id!,
                                                              type: element.type ??
                                                                  '',
                                                              message: element
                                                                      .message ??
                                                                  '',
                                                              time: getFormattedDate(
                                                                  element
                                                                      .createdAt!),
                                                              isRead:
                                                                  element.isRead!,
                                                              fromUser: true))
                                                          .toList()),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Obx(
                                          () => SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  ' Charity NotificationsPage',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .purple.shade200,
                                                      fontSize: 19),
                                                ),
                                                SingleChildScrollView(
                                                  child: Column(
                                                      children: controller
                                                          .allCharityNotification
                                                          .where((p0) =>
                                                              !p0.type!.contains(
                                                                  'Company'))
                                                          .map((element) => getListTitle(
                                                              id: element.id!,
                                                              type: element.type ??
                                                                  '',
                                                              message: element
                                                                      .message ??
                                                                  '',
                                                              time: getFormattedDate(
                                                                  element
                                                                      .createdAt!),
                                                              isRead:
                                                                  element.isRead!,
                                                              fromUser: false))
                                                          .toList()),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                  )),
          ],
        ),
      ),
    );
  }

  bool getEmpty() => controller.auth.getTypeEnum() == Auth.user
      ? controller.allUserNotification.isEmpty
      : controller.auth.getTypeEnum() == Auth.charity
          ? controller.allCharityNotification.isEmpty
          : controller.allUserNotification.isEmpty &&
              controller.allCharityNotification.isEmpty;

  Widget getListTitle(
      {required String type,
      required int id,
      required String time,
      required String message,
      required bool? fromUser,
      required bool isRead}) {
    return Card(
      child: ListTile(
        onTap: () => controller.makeRead(id, fromUser: fromUser),
        title: Text(type),
        trailing: isRead
            ? SizedBox.shrink()
            : const Icon(
                Icons.circle,
                color: Colors.red,
                size: 12,
              ),
        subtitle: Column(
          children: [
            Text(message),
            Text(
              time,
              style: TextStyle(color: Colors.purple.shade200),
            ),
          ],
        ),
      ),
    );
  }
}
