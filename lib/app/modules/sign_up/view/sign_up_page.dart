import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/sign_up/view/sign_up_charity.dart';
import 'package:marketing_surplus/app/modules/sign_up/view/sign_up_company.dart';
import 'package:marketing_surplus/app/modules/sign_up/view/sign_up_user.dart';
import 'package:marketing_surplus/app/routes/app_routes.dart';

import '../../../../shared/service/auth_service.dart';
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
                  height: 15,
                ),
                Center(
                  child: Text(
                    'hello-title'.tr,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 27),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/background_sign.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        )),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Obx(
                      () => DropdownButton<Auth>(
                        focusNode: FocusNode(canRequestFocus: false),
                        isExpanded: true,
                        hint: Text('plsi-title'.tr),
                        value: controller.authType.value,
                        onChanged: (newValue) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          controller.stringPickImage.value = '';
                          controller.authType.value = newValue!;
                        },
                        items: Auth.values
                            .where((element) => element != Auth.none)
                            .map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text('${e.name}-type'.tr),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Obx(() => controller.authType.value == Auth.comapny
                      ? const SignUpCompany()
                      : controller.authType.value == Auth.charity
                          ? const SignUpCharity()
                          : const SignUpUser()),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.rootDelegate.history.clear();
                        Get.rootDelegate.toNamed(Paths.LogIn);
                      },
                      child: Text('alr-title'.tr))
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
