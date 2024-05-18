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
            icon: Icons.person_2_outlined,
            value: controller.user.value.email,
            onChanged: (value) {
              controller.user.value.email = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Enter Your Email',
          ),
          TextFieldWidget(
            icon: Icons.person_2_outlined,
            value: controller.user.value.name,
            onChanged: (value) {
              controller.user.value.name = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Enter Your Name',
          ),
          TextFieldWidget(
            value: controller.user.value.password,
            onChanged: (value) {
              controller.user.value.password = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Enter Your Password',
          ),
          TextFieldWidget(
            value: controller.user.value.phone,
            onChanged: (value) {
              controller.user.value.phone = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Enter Your Phone',
          ),
        ],
      ),
    );
  }
}
