import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';

import '../../../../shared/widgets/empty_screen.dart';

class LastOrderCharity extends GetView<BillsController> {
  const LastOrderCharity({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.lastOrderCharity.isEmpty
        ? EmptyOrder()
        : Obx(
            () => Column(
              children: controller.lastOrderCharity
                  .map((element) => InkWell(
                        onTap: () {
                          // Overlayment.show(OverDialog(
                          //     child: OrderDetailsPage(
                          //   orderProduct: element,
                          // )));
                        },
                        child: Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                const Text('product Name :'),
                                Text(element.companyProduct!.product!.name ??
                                    ''),
                              ],
                            ),
                            trailing: Chip(
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 240, 210, 210),
                                ),
                                backgroundColor: Colors.purple.shade200,
                                label: Text(
                                  getType(element.donation!.orderTypeId ?? 0),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text('Total Price :'),
                                    Text(
                                      element.totalPrice != null
                                          ? element.totalPrice.toString()
                                          : '',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Price Pay :'),
                                    Text(
                                      element.donation!.pricePay != null
                                          ? element.donation!.pricePay
                                              .toString()
                                          : '',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ));
  }

  String getType(int id) =>
      controller.orderTypes.where((p0) => p0.id == id).first.name ?? '';
}
