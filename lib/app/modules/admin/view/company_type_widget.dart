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
      padding: const EdgeInsets.all(12),
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
                                  'Add Company Type',
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
                                      label: 'Type Name',
                                    ),
                                    TextFieldWidget(
                                      onChanged: (value) {
                                        controller.type.value.description =
                                            value;
                                      },
                                      textInputType: TextInputType.text,
                                      label: 'Type Discraption',
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
                                  child: const SizedBox(
                                    width: 150,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
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
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: controller.companyTypes
                      .map((element) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chip(
                              label: Text(element.type!),
                              deleteIcon: Icon(
                                Icons.delete,
                                color: Colors.purple.shade200,
                              ),
                              onDeleted: () async {
                                await controller.deladdCompanyTypelement(
                                    controller.type.value);
                              },
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
