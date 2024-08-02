import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_controller.dart';

class CharityRequst extends GetView<AdminController> {
  CharityRequst({super.key});
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
                const SizedBox(),
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

  List<DataColumn> getColumn() => controller.chRequstColumn
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
  List<DataRow> getRows() => controller.productDonation
      .map((element) => DataRow(cells: [
            DataCell(Text(element.id.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.companyProduct!.product!.name.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.companyProduct!.company!.name.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.totalPrice.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.donation!.orderTypeId.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.isAccept.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.isCompany.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.isCencal.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete, color: Colors.red),
            )),
          ]))
      .toList();
}
