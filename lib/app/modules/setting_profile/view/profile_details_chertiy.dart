import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/setting_profile/controller/setting_profile_controller.dart';

import '../../../../shared/widgets/textfield_widget.dart';

class ProfileDetailsChertiy extends GetView<SettingProfileController> {
  const ProfileDetailsChertiy({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(children: [
        Text(
          controller.charity.value.name == null
              ? ''
              : controller.charity.value.name!,
          style: TextStyle(
              color: Colors.purple.shade300,
              fontWeight: FontWeight.bold,
              fontSize: 21),
        ),
        TextFieldWidget(
          value: controller.charity.value.email,
          onChanged: (value) {
            controller.charity.value.email = value;
          },
          textInputType: TextInputType.emailAddress,
          label: 'entem-title'.tr,
          isReadOnly: controller.isNotEdit.value,
        ),
        TextFieldWidget(
          value: controller.charity.value.name,
          onChanged: (value) {
            controller.charity.value.name = value;
          },
          textInputType: TextInputType.emailAddress,
          label: 'entername-title'.tr,
          isReadOnly: controller.isNotEdit.value,
        ),
        TextFieldWidget(
          value: controller.charity.value.password,
          onChanged: (value) {
            controller.charity.value.password = value;
          },
          textInputType: TextInputType.emailAddress,
          label: 'entpass-title'.tr,
          isReadOnly: controller.isNotEdit.value,
        ),
        TextFieldWidget(
          value: controller.charity.value.address,
          onChanged: (value) {
            controller.charity.value.address = value;
          },
          textInputType: TextInputType.emailAddress,
          label: 'enteradd-title'.tr,
          isReadOnly: controller.isNotEdit.value,
        ),
        TextFieldWidget(
          value: controller.charity.value.associationLicense,
          onChanged: (value) {
            controller.charity.value.associationLicense = value;
          },
          textInputType: TextInputType.emailAddress,
          label: 'asslic-title'.tr,
          isReadOnly: controller.isNotEdit.value,
        ),
        TextFieldWidget(
          value: controller.charity.value.targetGroup,
          onChanged: (value) {
            controller.charity.value.targetGroup = value;
          },
          textInputType: TextInputType.emailAddress,
          label: 'target-title'.tr,
          isReadOnly: controller.isNotEdit.value,
        ),
      ]),
    );
  }
}
