import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlayment/overlayment.dart';

import '../controller/passowd_controller.dart';

class Confirmpassword extends GetView<PasswordController> {
  const Confirmpassword({super.key});
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
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/password_back.png',
                    width: 200,
                    height: 300,
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
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: controller.validatePassword,
                            keyboardType: TextInputType.text,
                            controller: controller.userPasswordController,
                            obscureText: !controller.passwordVisible.value,
                            onChanged: (value) {
                              controller.resrtpassword.value = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'pass-title'.tr,
                              hintText: 'entpass-title'.tr,
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
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
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            validator: controller.validatePassword,
                            controller: controller.userPasswordController1,
                            obscureText: !controller.passwordVisible1.value,
                            onChanged: (value) {
                              controller.password.value = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'enterconf-title'.tr,
                              hintText: 'entpass-title'.tr,
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.passwordVisible1.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  controller.passwordVisible1.value =
                                      !controller.passwordVisible1.value;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (controller.password.value.length ==
                          controller.resrtpassword.value.length) {
                        await controller.resetPassword();
                      } else {
                        OverPanel(
                            alignment: Alignment.bottomCenter,
                            width: 40,
                            height: 40,
                            child: Container(
                              child: Text(
                                'comf-title'.tr,
                                style: const TextStyle(color: Colors.red),
                              ),
                            )).show();
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
                          'save-title'.tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 21),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ))
      ],
    ));
  }
}
