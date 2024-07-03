import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/sign_up/controller/sign_up_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/widgets/textfield_widget.dart';
import '../../../data/model/company_type_model.dart';

class SignUpCompany extends GetView<SignUpController> {
  const SignUpCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextFieldWidget(
            icon: Icons.email,
            value: controller.company.value.email,
            onChanged: (value) {
              controller.company.value.email = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'entem-title'.tr,
          ),
          TextFieldWidget(
            icon: Icons.person_2_outlined,
            value: controller.company.value.name,
            onChanged: (value) {
              controller.company.value.name = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'entername-title'.tr,
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: controller.userPasswordController,
                obscureText: !controller.passwordVisible.value,
                onChanged: (value) {
                  controller.company.value.password = value;
                },
                decoration: InputDecoration(
                  icon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.password,
                      color: Colors.purple.shade100,
                    ), // icon is 48px widget.
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  labelText: 'pass-title'.tr,
                  hintText: 'entpass-title'.tr,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.passwordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      controller.passwordVisible.value =
                          !controller.passwordVisible.value;
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => DropdownButton<CompanyTypeModel>(
                isExpanded: true,
                hint: Text('pleasechos-title'.tr),
                value: controller.companyTypes
                    .where(
                        (p0) => p0.id == controller.company.value.companyTypeId)
                    .first,
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.company.value.companyTypeId = newValue.id;
                  } else {
                    Overlayment.show(OverDialog(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'addtyp-title'.tr,
                              style: TextStyle(
                                  color: Colors.purple.shade200,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldWidget(
                              onChanged: (value) {
                                controller.newType.value.type = value;
                              },
                              textInputType: TextInputType.text,
                              label: 'enteryourtyp-title'.tr,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldWidget(
                              onChanged: (value) {
                                controller.newType.value.description = value;
                              },
                              textInputType: TextInputType.text,
                              label: 'enterdes-title'.tr,
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                controller.newType.value.isAccept = false;
                                controller.addCompanyTypeModelelement(
                                    controller.newType.value);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple.shade100,
                                  shape: const StadiumBorder()),
                              child: Center(
                                child: Text(
                                  'save-title'.tr,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 21),
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    )));
                  }
                },
                items: controller.companyTypes.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.type!),
                  );
                }).toList()
                  ..add(DropdownMenuItem(child: Text('other-title'.tr))),
              ),
            ),
          ),
          TextFieldWidget(
            icon: Icons.verified_user,
            value: controller.company.value.licenseNumber,
            onChanged: (value) {
              controller.company.value.licenseNumber = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'licnum-title'.tr,
          ),
          TextFieldWidget(
            icon: Icons.location_on_rounded,
            value: controller.company.value.address,
            onChanged: (value) {
              controller.company.value.address = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'enteradd-title'.tr,
          ),
          TextFieldWidget(
            icon: Icons.phone,
            value: controller.company.value.telePhone,
            onChanged: (value) {
              controller.company.value.telePhone = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'tele-title'.tr,
          ),
          TextFieldWidget(
            icon: Icons.description,
            minLines: 2,
            value: controller.company.value.description,
            onChanged: (value) {
              controller.company.value.description = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'enterdess-title'.tr,
          ),
        ],
      ),
    );
  }
}
