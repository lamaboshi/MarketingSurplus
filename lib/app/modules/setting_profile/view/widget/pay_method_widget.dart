import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/service/auth_service.dart';
import '../../controller/setting_profile_controller.dart';

class PayMethodView extends GetView<SettingProfileController> {
  const PayMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.pays.isEmpty
        ? const Text('No Data')
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'paymeth-title'.tr,
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.purple.shade200,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    controller.auth.getTypeEnum() == Auth.comapny
                        ? Text(
                            'addd-title'.tr,
                            style: TextStyle(
                                fontSize: 18, color: Colors.purple.shade200),
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    children: controller.pays
                        .map((element) => ListTile(
                              leading: const Icon(
                                Icons.payment,
                                color: Colors.cyan,
                              ),
                              title: Text(element.name ?? ""),
                            ))
                        .toList()),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ));
  }
}
