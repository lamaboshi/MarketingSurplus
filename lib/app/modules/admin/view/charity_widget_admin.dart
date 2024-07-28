import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/textfield_widget.dart';
import '../controller/admin_controller.dart';

class CharityWidgetAdmin extends GetView<AdminController> {
  CharityWidgetAdmin({super.key});
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
                        'Sort By :',
                        style: TextStyle(color: Colors.purple.shade200),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Obx(() => DropdownButton<String>(
                            focusNode: FocusNode(),
                            underline: const SizedBox(),
                            hint: Text('selectcomp-title'.tr),
                            value: controller.charityColumnSelect.value,
                            onChanged: (newValue) async {
                              FocusScope.of(context).requestFocus(FocusNode());

                              controller.charityColumnSelect.value = controller
                                  .charityColumn
                                  .where(
                                      (element) => element.contains(newValue!))
                                  .first;
                            },
                            items: [
                              controller.charityColumn[1],
                              controller.charityColumn[2],
                              controller.charityColumn[3],
                              controller.charityColumn[4]
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
                              if (controller.charityColumnSelect.value
                                  .contains('Name')) {
                                var items = controller.charitys
                                    .where((p0) => p0.name!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                controller.charitys.clear();
                                controller.charitys.assignAll(items);
                              } else if (controller.charityColumnSelect.value
                                  .contains('Email')) {
                                var items = controller.charitys
                                    .where((p0) => p0.email!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                controller.charitys.clear();
                                controller.charitys.assignAll(items);
                              } else if (controller.charityColumnSelect.value
                                  .contains('TargetGroup')) {
                                var items = controller.charitys
                                    .where((p0) => p0.targetGroup!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                controller.charitys.clear();
                                controller.charitys.assignAll(items);
                              } else {
                                var items = controller.charitys
                                    .where((p0) => p0.goals!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                controller.charitys.clear();
                                controller.charitys.assignAll(items);
                              }
                            } else {
                              controller.getAllcharitys();
                            }
                          },
                          textInputType: TextInputType.name,
                          label: 'Search',
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

  List<DataColumn> getColumn() => controller.charityColumn
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
  List<DataRow> getRows() => controller.charitys
      .map((element) => DataRow(cells: [
            DataCell(Text(element.id.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.name.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.email.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.targetGroup.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(Text(element.goals.toString(),
                style: const TextStyle(color: Colors.purple))),
            DataCell(IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.blueGrey,
              ),
            )),
            DataCell(IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete, color: Colors.red),
            )),
            DataCell(IconButton(
              onPressed: () async {},
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
