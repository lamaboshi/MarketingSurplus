import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/textfield_widget.dart';
import '../../../data/model/company_type_model.dart';
import '../controller/setting_profile_controller.dart';

class ProfileDetailsCompany extends GetView<SettingProfileController> {
  const ProfileDetailsCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () => Column(
          children: [
            Text(
              controller.company.value.name == null
                  ? ''
                  : controller.company.value.name!,
              style: TextStyle(
                  color: Colors.purple.shade300,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
            TextFieldWidget(
              value: controller.company.value.email,
              onChanged: (value) {
                controller.company.value.email = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'Enter Your Email',
              isReadOnly: controller.isNotEdit.value,
            ),
            TextFieldWidget(
              value: controller.company.value.name,
              onChanged: (value) {
                controller.company.value.name = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'Enter Your Name',
              isReadOnly: controller.isNotEdit.value,
            ),
            TextFieldWidget(
              value: controller.company.value.password,
              onChanged: (value) {
                controller.company.value.password = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'Enter Your Password',
              isReadOnly: controller.isNotEdit.value,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => DropdownButton<CompanyTypeModel>(
                  isExpanded: true,
                  hint: const Text(
                      'Please choose a Type'), // Not necessary for Option 1
                  value: controller.companyTypes
                      .where((p0) =>
                          p0.id == controller.company.value.companyTypeId)
                      .first,
                  onChanged: controller.isNotEdit.value
                      ? null
                      : (newValue) {
                          FocusScope.of(context).requestFocus(FocusNode());
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
              isReadOnly: controller.isNotEdit.value,
            ),
            TextFieldWidget(
              value: controller.company.value.address,
              onChanged: (value) {
                controller.company.value.address = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'Enter Your Address',
              isReadOnly: controller.isNotEdit.value,
            ),
            TextFieldWidget(
              value: controller.company.value.telePhone,
              onChanged: (value) {
                controller.company.value.telePhone = value;
              },
              textInputType: TextInputType.emailAddress,
              isReadOnly: controller.isNotEdit.value,
              label: 'Tele Phone ',
            ),
          ],
        ),
      ),
    );
  }
}
