import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/setting_profile/controller/setting_profile_controller.dart';
import 'package:marketing_surplus/shared/widgets/empty_screen.dart';

import '../../../../../shared/service/auth_service.dart';

class OrderBillsWidget extends GetView<SettingProfileController> {
  const OrderBillsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.auth.getTypeEnum() != Auth.charity
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'allbil-title'.tr,
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.purple.shade200,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Obx(() => controller.orderProducts.isEmpty
                  ? const EmptyData()
                  : Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                          children: controller.orderProducts
                              .map((element) => ListTile(
                                    title: Text(element.order!.name ?? ""),
                                    subtitle:
                                        Text(element.order!.price.toString()),
                                  ))
                              .toList()),
                    )),
            ],
          )
        : controller.auth.getTypeEnum() == Auth.charity
            ? controller.lastOrderCharity.isEmpty
                ? Text('nobil-title'.tr)
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'allbil-title'.tr,
                          style: TextStyle(
                              fontSize: 21,
                              color: Colors.purple.shade200,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            children: controller.lastOrderCharity
                                .map((element) => ListTile(
                                      title: Text(
                                          element.donation!.orderType!.name ??
                                              ""),
                                      subtitle:
                                          Text(element.totalPrice.toString()),
                                    ))
                                .toList()),
                      ),
                    ],
                  )
            : SizedBox.shrink();
  }

  String getTotalPric() {
    var total = 0.0;
    for (var element in controller.orderProducts) {
      total += element.order!.price!;
    }
    return total.toString();
  }
}
