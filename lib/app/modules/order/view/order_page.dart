import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/order/controller/order_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/widgets/textfield_widget.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getData();
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'confiord-title'.tr,
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
            TextFieldWidget(
              onChanged: (String value) {
                controller.order.value.name = value;
              },
              textInputType: TextInputType.text,
              label: 'ordername-title'.tr,
            ),
            TextFieldWidget(
              onChanged: (String value) {
                controller.order.value.descripation = value;
              },
              textInputType: TextInputType.text,
              label: 'orderdes-title'.tr,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'chosepay-title'.tr,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Obx(() => controller.pays.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.pays
                            .map((element) => InkWell(
                                  onTap: () {
                                    controller.selectedPayMethod.value =
                                        element;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Chip(
                                        side: BorderSide(
                                            color: controller.selectedPayMethod
                                                        .value.id ==
                                                    element.id
                                                ? Colors.white
                                                : Colors.purple.shade200),
                                        backgroundColor: controller
                                                    .selectedPayMethod
                                                    .value
                                                    .id ==
                                                element.id
                                            ? Colors.purple.shade200
                                            : Colors.white,
                                        label: Text(
                                          element.name == null
                                              ? ''
                                              : element.name!,
                                          style: TextStyle(
                                            color: controller.selectedPayMethod
                                                        .value.id ==
                                                    element.id
                                                ? Colors.white
                                                : Colors.purple.shade200,
                                          ),
                                        )),
                                  ),
                                ))
                            .toList()),
                  )),
            Obx(
              () => CheckboxListTile(
                contentPadding: const EdgeInsets.all(8),
                title: Text('isdel-title'.tr),
                value: controller.order.value.isDelivery,
                onChanged: (newValue) {
                  controller.order.value.isDelivery = newValue;
                  controller.order.refresh();
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
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
                  child: Text(
                    ' ${controller.totalPrice.value} \$',
                    style: TextStyle(color: Colors.purple.shade200),
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
                child: FloatingActionButton.extended(
                    backgroundColor: Colors.purple.shade200,
                    isExtended: true,
                    onPressed: () async {
                      await controller.saveOrder();
                      Overlayment.dismissLast();
                    },
                    label: SizedBox(
                        height: Get.height / 3,
                        child: Center(
                            child: Text(
                          'conf-title'.tr,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        )))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
