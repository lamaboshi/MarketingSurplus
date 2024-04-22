import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/textfield_widget.dart';
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
                      TextFieldWidget(
                        onChanged: (value) {},
                        textInputType: TextInputType.emailAddress,
                        label: 'Enter Your Password',
                      ),
                      TextFieldWidget(
                        onChanged: (value) {},
                        textInputType: TextInputType.emailAddress,
                        label: 'Enter Your Confirm Password',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade100,
                        shape: const StadiumBorder()),
                    child: SizedBox(
                      width: Get.width / 1.3,
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 21),
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
