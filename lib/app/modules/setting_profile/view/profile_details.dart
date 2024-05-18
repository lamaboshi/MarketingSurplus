import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../../shared/widgets/textfield_widget.dart';
import '../controller/setting_profile_controller.dart';
import 'profile_detail_company.dart';
import 'profile_details_chertiy.dart';

class ProfileDetails extends GetView<SettingProfileController> {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                const SizedBox(
                  height: 160,
                ),
                Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    color: Colors.purple.shade100,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    )),
                    child: SizedBox(
                      height: 120,
                      width: Get.width,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.isNotEdit.value = false;
                                },
                                icon:
                                    const Icon(color: Colors.white, Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                    color: Colors.white, Icons.logout),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                Positioned(
                  bottom: 0,
                  right: Get.width / 2.5,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side:
                            BorderSide(color: Colors.purple.shade100, width: 4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(80))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.person_2,
                        color: Colors.purple.shade100,
                        size: 80,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => controller.authType.value == Auth.user
                        ? const UserProfileDetails()
                        : controller.authType.value == Auth.comapny
                            ? const ProfileDetailsCompany()
                            : controller.authType.value == Auth.charity
                                ? const ProfileDetailsChertiy()
                                : const SizedBox(),
                  )
                ],
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: controller.isNotEdit.value
            ? null
            : FloatingActionButton.extended(
                backgroundColor: Colors.purple.shade200,
                isExtended: true,
                onPressed: () async {
                  await controller.updateObject();
                },
                label: SizedBox(
                    width: Get.width / 3,
                    child: const Center(
                        child: Text(
                      'Save',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )))),
      ),
    );
  }
}

class UserProfileDetails extends GetView<SettingProfileController> {
  const UserProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Text(
            controller.user.value.name == null
                ? ''
                : controller.user.value.name!,
            style: TextStyle(
                color: Colors.purple.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 21),
          ),
          TextFieldWidget(
            value: controller.user.value.email,
            onChanged: (value) {
              controller.user.value.email = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Enter Your Email',
            isReadOnly: controller.isNotEdit.value,
          ),
          TextFieldWidget(
            value: controller.user.value.name,
            onChanged: (value) {
              controller.user.value.name = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Enter Your Name',
            isReadOnly: controller.isNotEdit.value,
          ),
          TextFieldWidget(
            value: controller.user.value.password,
            onChanged: (value) {
              controller.user.value.password = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Enter Your Password',
            isReadOnly: controller.isNotEdit.value,
          ),
          TextFieldWidget(
            value: controller.user.value.phone,
            onChanged: (value) {
              controller.user.value.phone = value;
            },
            textInputType: TextInputType.emailAddress,
            label: 'Enter Your Phone',
            isReadOnly: controller.isNotEdit.value,
          ),
        ],
      ),
    );
  }
}
