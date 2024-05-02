import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_type_model.dart';
import 'package:marketing_surplus/app/routes/app_routes.dart';

import '../../../../shared/widgets/textfield_widget.dart';
import '../controller/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: Card(
          elevation: 8,
          margin: EdgeInsets.zero,
          color: Colors.purple.shade100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(60),
          )),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    'Hello!',
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 27),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/background_sign.png',
                  ),
                ),
              ],
            ),
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: CheckboxListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text("is Company"), //    <-- label
                    value: controller.isCompany.value,
                    onChanged: (newValue) {
                      controller.isCompany.value = newValue!;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.purpleAccent,
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        value: controller.isCompany.value
                            ? controller.company.value.email
                            : controller.user.value.email,
                        onChanged: (value) {
                          controller.isCompany.value
                              ? controller.company.value.email = value
                              : controller.user.value.email = value;
                        },
                        textInputType: TextInputType.emailAddress,
                        label: 'Enter Your Email',
                      ),
                      TextFieldWidget(
                        value: controller.isCompany.value
                            ? controller.company.value.name
                            : controller.user.value.name,
                        onChanged: (value) {
                          controller.isCompany.value
                              ? controller.company.value.name = value
                              : controller.user.value.name = value;
                        },
                        textInputType: TextInputType.emailAddress,
                        label: 'Enter Your Name',
                      ),
                      TextFieldWidget(
                        value: controller.isCompany.value
                            ? controller.company.value.password
                            : controller.user.value.password,
                        onChanged: (value) {
                          controller.isCompany.value
                              ? controller.company.value.password = value
                              : controller.user.value.password = value;
                        },
                        textInputType: TextInputType.emailAddress,
                        label: 'Enter Your Password',
                      ),
                      TextFieldWidget(
                        value: controller.isCompany.value
                            ? controller.company.value.address
                            : controller.user.value.address,
                        onChanged: (value) {
                          controller.isCompany.value
                              ? controller.company.value.address = value
                              : controller.user.value.address = value;
                        },
                        textInputType: TextInputType.emailAddress,
                        label: 'Enter Your Address',
                      ),
                      Obx(
                        () => Column(
                          children: [
                            controller.isCompany.value
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Obx(
                                          () =>
                                              DropdownButton<CompanyTypeModel>(
                                            isExpanded: true,
                                            hint: const Text(
                                                'Please choose a Type'), // Not necessary for Option 1
                                            value: controller.companyTypes
                                                .where((p0) =>
                                                    p0.id ==
                                                    controller.company.value
                                                        .companyTypeId)
                                                .first,
                                            onChanged: (newValue) {
                                              controller.company.value
                                                  .companyTypeId = newValue!.id;
                                            },
                                            items: controller.companyTypes
                                                .map((e) {
                                              return DropdownMenuItem(
                                                value: e,
                                                child: Text(e.type!),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      TextFieldWidget(
                                        value: controller
                                            .company.value.licenseNumber,
                                        onChanged: (value) {
                                          controller.company.value
                                              .licenseNumber = value;
                                        },
                                        textInputType:
                                            TextInputType.emailAddress,
                                        label: 'License Number',
                                      ),
                                      TextFieldWidget(
                                        value:
                                            controller.company.value.telePhone,
                                        onChanged: (value) {
                                          controller.company.value.telePhone =
                                              value;
                                        },
                                        textInputType:
                                            TextInputType.emailAddress,
                                        label: 'Tele Phone ',
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      controller.isCompany.value
                          ? await controller.signUpCompany()
                          : await controller.signUpUser();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade100,
                        shape: const StadiumBorder()),
                    child: SizedBox(
                      width: Get.width / 1.3,
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 21),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      Get.rootDelegate.toNamed(Paths.LogIn);
                    },
                    child: const Text('Already have an account ?!'))
              ],
            ),
          ),
        ))
      ],
    ));
  }
}
