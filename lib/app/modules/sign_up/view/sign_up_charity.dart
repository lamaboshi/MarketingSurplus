import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/sign_up/controller/sign_up_controller.dart';

import '../../../../shared/widgets/textfield_widget.dart';

class SignUpCharity extends GetView<SignUpController> {
  const SignUpCharity({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(children: [
        TextFieldWidget(
          icon: Icons.email,
          value: controller.charity.value.email,
          onChanged: (value) {
            controller.charity.value.email = value;
          },
          textInputType: TextInputType.emailAddress,
          label: 'entem-title'.tr,
        ),
        TextFieldWidget(
          icon: Icons.person_2_outlined,
          value: controller.charity.value.name,
          onChanged: (value) {
            controller.charity.value.name = value;
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
                controller.charity.value.password = value;
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
        TextFieldWidget(
          icon: Icons.location_on,
          value: controller.charity.value.address,
          onChanged: (value) {
            controller.charity.value.address = value;
          },
          textInputType: TextInputType.emailAddress,
          label: 'enteradd-title'.tr,
        ),
        Column(
          children: [
            TextFieldWidget(
              icon: Icons.verified,
              value: controller.charity.value.associationLicense,
              onChanged: (value) {
                controller.charity.value.associationLicense = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'asslic-title'.tr,
            ),
            TextFieldWidget(
              icon: Icons.people_outline_rounded,
              value: controller.charity.value.targetGroup,
              onChanged: (value) {
                controller.charity.value.targetGroup = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'target-title'.tr,
            ),
          ],
        )
      ]),
    );
  }
}
