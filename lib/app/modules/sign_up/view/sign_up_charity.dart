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
          icon: Icons.person_2_outlined,
          value: controller.charity.value.email,
          onChanged: (value) {
            controller.charity.value.email = value;
          },
          textInputType: TextInputType.emailAddress,
          label: 'Enter Your Email',
        ),
        TextFieldWidget(
          icon: Icons.person_2_outlined,
          value: controller.charity.value.name,
          onChanged: (value) {
            controller.charity.value.name = value;
          },
          textInputType: TextInputType.emailAddress,
          label: 'Enter Your Name',
        ),
        TextFieldWidget(
          icon: Icons.person_2_outlined,
          value: controller.charity.value.password,
          onChanged: (value) {
            controller.charity.value.password = value;
          },
          textInputType: TextInputType.emailAddress,
          label: 'Enter Your Password',
        ),
        TextFieldWidget(
          icon: Icons.person_2_outlined,
          value: controller.charity.value.address,
          onChanged: (value) {
            controller.charity.value.address = value;
          },
          textInputType: TextInputType.emailAddress,
          label: 'Enter Your Address',
        ),
        Column(
          children: [
            TextFieldWidget(
              icon: Icons.person_2_outlined,
              value: controller.charity.value.associationLicense,
              onChanged: (value) {
                controller.charity.value.associationLicense = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'Association License',
            ),
            TextFieldWidget(
              icon: Icons.person_2_outlined,
              value: controller.charity.value.targetGroup,
              onChanged: (value) {
                controller.charity.value.targetGroup = value;
              },
              textInputType: TextInputType.emailAddress,
              label: 'Target Group ',
            ),
          ],
        )
      ]),
    );
  }
}
