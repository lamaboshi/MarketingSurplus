import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/textfield_widget.dart';
import '../controller/admin_controller.dart';

class OrderWidget extends GetView<AdminController> {
  OrderWidget({super.key});
  final controllerVertical = ScrollController();
  final controllerHorizontal = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'sort-title'.tr,
                        style: TextStyle(color: Colors.purple.shade200),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Obx(() => DropdownButton<String>(
                            focusNode: FocusNode(),
                            underline: const SizedBox(),
                            hint: Text('selectcomp-title'.tr),
                            value: controller.orderColumnSelect.value,
                            onChanged: (newValue) async {
                              FocusScope.of(context).requestFocus(FocusNode());

                              controller.orderColumnSelect.value = controller
                                  .orderColumn
                                  .where(
                                      (element) => element.contains(newValue!))
                                  .first;
                            },
                            items: [
                              controller.orderColumn[1],
                              controller.orderColumn[4],
                              controller.orderColumn[7]
                            ].map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e.tr),
                              );
                            }).toList(),
                          )),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFieldWidget(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple.shade200)),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (controller.orderColumnSelect.value
                                  .contains('Name')) {
                                var items = controller.orders
                                    .where((p0) => p0.name!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                controller.orders.clear();
                                controller.orders.assignAll(items);
                              } else if (controller.orderColumnSelect.value
                                  .contains('Price')) {
                                var items = controller.orders
                                    .where((p0) => p0.price
                                        .toString()
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                controller.orders.clear();
                                controller.orders.assignAll(items);
                              } else {
                                var items = controller.orders
                                    .where((p0) => p0.userId
                                        .toString()
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                controller.orders.clear();
                                controller.orders.assignAll(items);
                              }
                            } else {
                              controller.getAllOrders();
                            }
                          },
                          textInputType: TextInputType.name,
                          label: 'Search'.tr,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(),
              ],
            ),
            Obx(() => SizedBox(
                  width: Get.width / 1.3,
                  child: Scrollbar(
                      controller: controllerVertical,
                      trackVisibility: true,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: controllerHorizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DataTable(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.purple),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            columns: getColumn(),
                            rows: getRows(),
                          ),
                        ),
                      )),
                )),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  List<DataColumn> getColumn() => controller.orderColumn
      .map((e) => DataColumn(
          label: Text(e,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.purple))))
      .toList()
    ..addAll([
      DataColumn(
          label: Text('delete-title'.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.purple))),
    ]);
  List<DataRow> getRows() => controller.orders
      .map((element) => DataRow(cells: [
            DataCell(Text(element.id.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.name.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.descripation.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.amount.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.price.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.isDelivery.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.payMethodId.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.userId.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete, color: Colors.red),
            )),
          ]))
      .toList();
}
