import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/admin/controller/admin_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/widgets/textfield_widget.dart';

class OrderTypeWidget extends GetView<AdminController> {
  const OrderTypeWidget({super.key});

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
                const SizedBox(),
                IconButton(
                  onPressed: () {
                    Overlayment.show(
                      OverDialog(
                        width: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'addord-title'.tr,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.purple.shade200),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFieldWidget(
                                  onChanged: (value) {
                                    controller.orderType.value.name = value;
                                  },
                                  textInputType: TextInputType.text,
                                  label: 'nameord-title'.tr,
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    await controller.addOrderType();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple.shade200,
                                      shape: const StadiumBorder()),
                                  child: SizedBox(
                                    width: 150,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        'save-title'.tr,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 19),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  color: Colors.purple.shade200,
                )
              ],
            ),
            Obx(() => SizedBox(
                  width: Get.width / 1.3,
                  child: DataTable(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    columns: getColumn(),
                    rows: getRows(),
                  ),
                )),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  List<DataColumn> getColumn() => controller.orderTypeColumn
      .map((e) => DataColumn(
          label: Text(e,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.purple))))
      .toList()
    ..addAll([
      DataColumn(
          label: Text('edit-title'.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.purple))),
      DataColumn(
          label: Text('delete-title'.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.purple))),
      DataColumn(
          label: Text('Accept'.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.purple))),
    ]);
  List<DataRow> getRows() => controller.orderTypes
      .map((element) => DataRow(cells: [
            DataCell(Text(element.id.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.name.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(IconButton(
              onPressed: () async {
                controller.orderType.value = element;
                Overlayment.show(
                  OverDialog(
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'updateord-title'.tr,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.purple.shade200),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldWidget(
                              value: controller.orderType.value.name,
                              onChanged: (value) {
                                controller.orderType.value.name = value;
                              },
                              textInputType: TextInputType.text,
                              label: 'nameord-title'.tr,
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await controller.updateOrderType();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple.shade200,
                                  shape: const StadiumBorder()),
                              child: SizedBox(
                                width: 150,
                                height: 30,
                                child: Center(
                                  child: Text(
                                    'save-title'.tr,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.blueGrey,
              ),
            )),
            DataCell(IconButton(
              onPressed: () async {
                await controller.deleteOrderType(element.id!);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            )),
            DataCell(IconButton(
              onPressed: () async {
                if (!element.isAccept!) {
                  controller.acceptOrderType(element.id!, true);
                }
              },
              icon: Icon(
                element.isAccept!
                    ? Icons.done_outline_rounded
                    : Icons.circle_outlined,
                color: Colors.blue,
              ),
            )),
          ]))
      .toList();
}
