import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/modules/setting_profile/controller/setting_profile_controller.dart';

class HelpOrder extends GetView<SettingProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(40))),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Clout',
                style: TextStyle(
                    color: Colors.purple.shade200,
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
            ],
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'cloutapp-title'.tr,
                      style: TextStyle(
                          fontSize: 19, color: Colors.purple.shade200),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'mach-title'.tr,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'fromhom-title'.tr,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'then-title'.tr,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'fromoffer-title'.tr,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'thenenter-title'.tr,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ));
  }
}
