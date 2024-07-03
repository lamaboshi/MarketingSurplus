import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/sign_up/controller/sign_up_controller.dart';

import '../../../../shared/widgets/textfield_widget.dart';

class SignUpUser extends GetView<SignUpController> {
  const SignUpUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextFieldWidget(
            icon: Icons.email,
            value: controller.user.value.email,
            onChanged: (value) {
              controller.user.value.email = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'entem-title'.tr,
          ),
          TextFieldWidget(
            icon: Icons.person_2_outlined,
            value: controller.user.value.name,
            onChanged: (value) {
              controller.user.value.name = value;
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
                  controller.user.value.password = value;
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
            icon: Icons.phone,
            value: controller.user.value.phone,
            onChanged: (value) {
              controller.user.value.phone = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'tele-title'.tr,
          ),
        ],
      ),
    );
  }
}
