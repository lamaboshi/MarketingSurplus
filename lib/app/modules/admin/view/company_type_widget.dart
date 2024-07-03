import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/admin/controller/admin_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/widgets/textfield_widget.dart';

class CompanyTypeWidget extends GetView<AdminController> {
  const CompanyTypeWidget({super.key});

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
                                  'add-title'.tr,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.purple.shade200),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextFieldWidget(
                                      onChanged: (value) {
                                        controller.type.value.type = value;
                                      },
                                      textInputType: TextInputType.text,
                                      label: 'type-title'.tr,
                                    ),
                                    TextFieldWidget(
                                      onChanged: (value) {
                                        controller.type.value.description =
                                            value;
                                      },
                                      textInputType: TextInputType.text,
                                      label: 'typedis-title'.tr,
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    await controller.addCompanyTypeModelelement(
                                        controller.type.value);
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

  List<DataColumn> getColumn() => controller.typeColumn
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
    ]);
  List<DataRow> getRows() => controller.companyTypes
      .map((element) => DataRow(cells: [
            DataCell(Text(element.id.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.type.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.description.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(IconButton(
              onPressed: () {
                controller.type.value = element;
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
                              'add-title'.tr,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.purple.shade200),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                TextFieldWidget(
                                  value: controller.type.value.type,
                                  onChanged: (value) {
                                    controller.type.value.type = value;
                                  },
                                  textInputType: TextInputType.text,
                                  label: 'type-title'.tr,
                                ),
                                TextFieldWidget(
                                  value: controller.type.value.description,
                                  onChanged: (value) {
                                    controller.type.value.description = value;
                                  },
                                  textInputType: TextInputType.text,
                                  label: 'typedis-title'.tr,
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await controller.updateCompanyType();
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
                await controller.deladdCompanyTypelement(element);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            )),
          ]))
      .toList();
}
