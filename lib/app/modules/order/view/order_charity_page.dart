import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/order_controller.dart';

class OrderCharityPage extends GetView<OrderController> {
  const OrderCharityPage({super.key});
  @override
  Widget build(BuildContext context) {
    controller.getData();
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'con-charity'.tr,
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.purple.shade200,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => controller.selectedType.value.id == 3
                ? Row(
                    children: controller.parc
                        .map((e) => InkWell(
                            onTap: () {
                              controller.selectPers.value = e;
                            },
                            child: Obx(() => Chip(
                                color: MaterialStatePropertyAll(
                                    controller.selectPers.value != e
                                        ? Colors.white
                                        : Colors.purple.shade200),
                                label: Text(
                                  '$e %',
                                  style: TextStyle(
                                      color: controller.selectPers.value == e
                                          ? Colors.white
                                          : Colors.purple.shade200),
                                )))))
                        .toList(),
                  )
                : SizedBox.shrink()),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'cho-type'.tr,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Obx(() => controller.orderTypes.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.orderTypes
                            .map((element) => InkWell(
                                  onTap: () {
                                    controller.selectedType.value = element;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Chip(
                                        side: BorderSide(
                                            color: controller.selectedType.value
                                                        .id ==
                                                    element.id
                                                ? Colors.white
                                                : Colors.purple.shade200),
                                        backgroundColor:
                                            controller.selectedType.value.id ==
                                                    element.id
                                                ? Colors.purple.shade200
                                                : Colors.white,
                                        label: Text(
                                          element.name == null
                                              ? ''
                                              : element.name!,
                                          style: TextStyle(
                                            color: controller.selectedType.value
                                                        .id ==
                                                    element.id
                                                ? Colors.white
                                                : Colors.purple.shade200,
                                          ),
                                        )),
                                  ),
                                ))
                            .toList()),
                  )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'total-title'.tr,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.money),
                      Text(
                        ' ${controller.totalPrice.value}',
                        style: TextStyle(color: Colors.purple.shade200),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => controller.isProssing.value
                    ? CircularProgressIndicator()
                    : FloatingActionButton.extended(
                        backgroundColor: Colors.purple.shade200,
                        isExtended: true,
                        onPressed: () async {
                          await controller.saveOrderDonation();
                        },
                        label: SizedBox(
                            height: Get.height / 3,
                            child: Center(
                                child: Text(
                              'conf-title'.tr,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ))))),
              ),
            )
          ],
        ));
  }
}
