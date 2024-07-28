import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/sign_up/controller/sign_up_controller.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../../shared/service/util.dart';
import '../../../../shared/widgets/textfield_widget.dart';

class SignUpCharity extends GetView<SignUpController> {
  const SignUpCharity({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Obx(() => ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(75), // Image radius
                    child: controller.stringPickImage.value.isNotEmpty
                        ? Utility.imageFromBase64String(
                            controller.stringPickImage.value, null, null)
                        : Icon(
                            Icons.person,
                            size: 45,
                          ),
                  ),
                ))),
        SizedBox(
          height: 5,
        ),
        InkWell(
            onTap: () {
              controller.pickImageFun();
            },
            child: Text('AddYourPhoto'.tr)),
        Form(
          key: controller.influencerForm,
          child: Column(
            children: [
              TextFieldWidget(
                icon: Icons.email,
                validator: controller.forceValue,
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
                validator: controller.forceValue,
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
                    validator: controller.validatePassword,
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
                validator: controller.forceValue,
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
                    validator: controller.forceValue,
                    value: controller.charity.value.associationLicense,
                    onChanged: (value) {
                      controller.charity.value.associationLicense = value;
                    },
                    textInputType: TextInputType.emailAddress,
                    label: 'asslic-title'.tr,
                  ),
                  TextFieldWidget(
                    validator: controller.forceValue,
                    icon: Icons.people_outline_rounded,
                    value: controller.charity.value.targetGroup,
                    onChanged: (value) {
                      controller.charity.value.targetGroup = value;
                    },
                    textInputType: TextInputType.emailAddress,
                    label: 'target-title'.tr,
                  ),
                ],
              ),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              if (controller.influencerForm.currentState!.validate()) {
                Overlayment.show(OverDialog(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outlined,
                          color: Colors.purple.shade200,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('AreyousurewanttoSaveYourData'.tr),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElevatedButton(
                        onPressed: () async {
                          controller.isSaveData.value = true;
                          controller.authType.value == Auth.comapny
                              ? await controller.signUpCompany()
                              : controller.authType.value == Auth.user
                                  ? await controller.signUpUser()
                                  : controller.authType.value == Auth.charity
                                      ? controller.signUpCharity()
                                      : () {};
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.purple.shade200),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        child: Text('Yes'.tr),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          controller.isSaveData.value = false;
                          Overlayment.dismissLast();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.purple.shade200),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        child: Text('Cancel'.tr),
                      ),
                    ]),
                  ],
                )));
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
                shape: const StadiumBorder()),
            child: SizedBox(
              width: Get.width / 1.3,
              height: 60,
              child: Center(
                child: Text(
                  'reg-title'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 21),
                ),
              ),
            )),
      ]),
    );
  }
}
