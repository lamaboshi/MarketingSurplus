import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_controller.dart';

class RateWidget extends GetView<AdminController> {
  const RateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: [
            const SizedBox(height: 30),
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
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  List<DataColumn> getColumn() => controller.rateColumn
      .map((e) => DataColumn(
          label: Text(e,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.purple))))
      .toList();

  List<DataRow> getRows() => controller.rates
      .map((element) => DataRow(cells: [
            DataCell(Text(element.id.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.rate!.rateNumber.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.rate!.description.toString(),
                style: const TextStyle(color: Colors.purple))),
          ]))
      .toList();
}
