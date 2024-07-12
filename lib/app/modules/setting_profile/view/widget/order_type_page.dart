import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/setting_profile/controller/setting_profile_controller.dart';

import '../../../../../shared/widgets/textfield_widget.dart';

class OrderTypeView extends GetView<SettingProfileController> {
  const OrderTypeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.orderTypes.isEmpty
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
                        'Order Type'.tr,
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.purple.shade200,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    children: controller.orderTypes
                        .map((element) => ListTile(
                              leading: const Icon(
                                Icons.payment,
                                color: Colors.cyan,
                              ),
                              title: Text(element.name ?? ""),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {},
                              ),
                            ))
                        .toList()),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ));
  }

  Widget addTypeOrder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Add Type Order',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.purple.shade200,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextFieldWidget(
            onChanged: (value) {
              controller.newOrderType.value.name = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Add Type Name'.tr,
          ),
        ],
      ),
    );
  }
}
