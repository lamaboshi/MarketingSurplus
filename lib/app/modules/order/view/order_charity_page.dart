import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/textfield_widget.dart';
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
            TextFieldWidget(
              onChanged: (String value) {
                controller.donation.value.pricePay = double.tryParse(value);
              },
              textInputType: TextInputType.number,
              label: 'num-pay'.tr,
            ),
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
                      await controller.saveOrderDonation();
                      Navigator.of(context).pop();
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
        ));
  }
}
