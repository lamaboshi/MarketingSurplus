import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/sign_up/controller/sign_up_controller.dart';

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
            value: controller.company.value.email,
            onChanged: (value) {
              controller.company.value.email = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Enter Your Email',
          ),
          TextFieldWidget(
            value: controller.company.value.name,
            onChanged: (value) {
              controller.company.value.name = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Enter Your Name',
          ),
          TextFieldWidget(
            value: controller.company.value.password,
            onChanged: (value) {
              controller.company.value.password = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Enter Your Password',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => DropdownButton<CompanyTypeModel>(
                isExpanded: true,
                hint: const Text(
                    'Please choose a Type'), // Not necessary for Option 1
                value: controller.companyTypes
                    .where(
                        (p0) => p0.id == controller.company.value.companyTypeId)
                    .first,
                onChanged: (newValue) {
                  controller.company.value.companyTypeId = newValue!.id;
                },
                items: controller.companyTypes.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.type!),
                  );
                }).toList(),
              ),
            ),
          ),
          TextFieldWidget(
            value: controller.company.value.licenseNumber,
            onChanged: (value) {
              controller.company.value.licenseNumber = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'License Number',
          ),
          TextFieldWidget(
            value: controller.company.value.address,
            onChanged: (value) {
              controller.company.value.address = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Enter Your Address',
          ),
          TextFieldWidget(
            value: controller.company.value.telePhone,
            onChanged: (value) {
              controller.company.value.telePhone = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Tele Phone ',
          ),
        ],
      ),
    );
  }
}
