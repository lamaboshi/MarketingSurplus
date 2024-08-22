import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/textfield_widget.dart';
import '../controller/admin_controller.dart';

class CompanyWidget extends GetView<AdminController> {
  const CompanyWidget({super.key});

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
                            value: controller.companyColumnSelect.value,
                            onChanged: (newValue) async {
                              FocusScope.of(context).requestFocus(FocusNode());

                              controller.companyColumnSelect.value = controller
                                  .companyColumn
                                  .where(
                                      (element) => element.contains(newValue!))
                                  .first;
                            },
                            items: [
                              controller.companyColumn[1],
                              controller.companyColumn[3]
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
                              if (controller.companyColumnSelect.value
                                  .contains('Name')) {
                                var items = controller.companys
                                    .where((p0) => p0.name!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                controller.companys.clear();
                                controller.companys.assignAll(items);
                              } else {
                                var items = controller.companys
                                    .where((p0) => p0.email!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                controller.companys.clear();
                                controller.companys.assignAll(items);
                              }
                            } else {
                              controller.getAllCompany();
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

  List<DataColumn> getColumn() => controller.companyColumn
      .map((e) => DataColumn(
          label: Text(e,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.purple))))
      .toList()
    ..addAll([
      // DataColumn(
      //     label: Text('edit-title'.tr,
      //         style: const TextStyle(
      //             fontWeight: FontWeight.bold, color: Colors.purple))),
      DataColumn(
          label: Text('delete-title'.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.purple))),
      DataColumn(
          label: Text('Accept'.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.purple))),
    ]);
  List<DataRow> getRows() => controller.companys
      .map((element) => DataRow(cells: [
            DataCell(Text(element.id.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.name.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.phone.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.email.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.address.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.telePhone.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.licenseNumber.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.companyTypeId.toString(),
                style: const TextStyle(color: Colors.purple))),
            // DataCell(IconButton(
            //   onPressed: () {},
            //   icon: const Icon(
            //     Icons.edit,
            //     color: Colors.blueGrey,
            //   ),
            // )),
            DataCell(IconButton(
              onPressed: () {
                controller.deleteCompany(element.id!);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            )),
            DataCell(IconButton(
              onPressed: () async {
                if (!element.isAccept!) {
                  controller.acceptCompany(element.id!, true);
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
