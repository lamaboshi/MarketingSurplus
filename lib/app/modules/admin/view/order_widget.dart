import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_controller.dart';

class OrderWidget extends GetView<AdminController> {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  color: Colors.purple.shade200,
                )
              ],
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: controller.orders
                      .map((element) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chip(
                              label: Text(element.name!),
                            ),
                          ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
