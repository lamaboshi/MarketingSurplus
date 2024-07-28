import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/order/controller/order_controller.dart';
import 'package:marketing_surplus/app/modules/order/view/map_circle.dart';
import 'package:overlayment/overlayment.dart';

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
            Form(
              key: controller.keyForm,
              child: Column(
                children: [
                  // TextFieldWidget(
                  //   validator: controller.forceValue,
                  //   onChanged: (String value) {
                  //     controller.order.value.descripation = value;
                  //   },
                  //   textInputType: TextInputType.text,
                  //   label: 'orderdes-title'.tr,
                  // ),
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
                                                  color: controller
                                                              .selectedPayMethod
                                                              .value
                                                              .id ==
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
                                                element.payMethod!.name == null
                                                    ? ''
                                                    : element.payMethod!.name!,
                                                style: TextStyle(
                                                  color: controller
                                                              .selectedPayMethod
                                                              .value
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
                  Obx(
                    () => CheckboxListTile(
                      contentPadding: const EdgeInsets.all(8),
                      title: Text('isdel-title'.tr),
                      value: controller.order.value.isDelivery,
                      onChanged: (newValue) {
                        controller.order.value.isDelivery = newValue;
                        controller.selectedArea.value = 5;
                        controller.order.refresh();
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  ),
                  Obx(() => controller.order.value.isDelivery!
                      ? Column(children: [
                          Text('Palce Choose Area naer To You'),
                          SizedBox(height: 250, child: ManyCirclesPage()),
                          Row(
                              children: controller.colorWay
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextButton(
                                            onPressed: () {
                                              controller.selectedArea.value =
                                                  controller.colorWay
                                                      .indexOf(e);
                                            },
                                            style: ButtonStyle(
                                                backgroundColor: controller
                                                                .selectedArea
                                                                .value <
                                                            3 &&
                                                        controller.colorWay
                                                                .indexOf(e) ==
                                                            controller
                                                                .selectedArea
                                                                .value
                                                    ? MaterialStateProperty.all(
                                                        Colors.red)
                                                    : MaterialStateProperty.all(
                                                        e)),
                                            child: Text(controller.colorWay
                                                .indexOf(e)
                                                .toString())),
                                      ))
                                  .toList()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  'Cost Delivery will be'.tr,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.money),
                                    Obx(() => Text(
                                          (controller.selectedArea.value < 3
                                                  ? controller.costs[controller
                                                      .selectedArea.value]
                                                  : 0)
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.purple.shade200),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ])
                      : SizedBox.shrink()),
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
                              ' ${controller.totalPrice.value} ',
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
                      child: Row(
                        children: [
                          FloatingActionButton.extended(
                              backgroundColor: Colors.purple.shade200,
                              isExtended: true,
                              onPressed: () async {
                                if (controller.keyForm.currentState!
                                    .validate()) {
                                  await controller.saveOrder();
                                  Overlayment.dismissLast();
                                }
                              },
                              label: SizedBox(
                                  height: Get.height / 3,
                                  child: Center(
                                      child: Text(
                                    'conf-title'.tr,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  )))),
                          SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Overlayment.dismissLast();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.purple.shade200),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            child: Text('Cancel'.tr),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
