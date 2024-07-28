import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:marketing_surplus/app/routes/app_routes.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../controller/intro_controller.dart';

class IntroPage extends GetView<IntroController> {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          interProductPage(context),
          interDeliveryPage(context),
          interPaymentPage(context)
        ],
        done: Text("done-title".tr,
            style: const TextStyle(
                color: Colors.purple, fontWeight: FontWeight.w600)),
        showNextButton: true,
        showBackButton: true,
        showSkipButton: false,
        onDone: () {
          Get.rootDelegate.history.clear();
          Get.rootDelegate.toNamed(Paths.SignUpUserPage);
        },
        back: Text("back-title".tr,
            style: const TextStyle(
                color: Colors.purple, fontWeight: FontWeight.w600)),
        next: Text("next-title".tr,
            style: const TextStyle(
                color: Colors.purple, fontWeight: FontWeight.w600)),
        globalBackgroundColor: Colors.white,
        dotsDecorator: const DotsDecorator(
          color: Colors.purple,
          activeColor: Colors.purple,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }

  PageViewModel interProductPage(context) {
    return PageViewModel(
      decoration:
          const PageDecoration(bodyFlex: 10, bodyPadding: EdgeInsets.zero),

      ///image
      titleWidget: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ToggleSwitch(
              minWidth: 70.0,
              cornerRadius: 20.0,
              activeBgColors: [
                [Colors.purple.shade200],
                [Colors.purple.shade200]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey.shade300,
              inactiveFgColor: Colors.purple.shade200,
              initialLabelIndex: 1,
              totalSwitches: 2,
              labels: controller.listTextTabToggle,
              radiusStyle: true,
              onToggle: (index) {
                controller.toggle(index!);
              },
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.rootDelegate.history.clear();
                    Get.rootDelegate.toNamed(Paths.LogIn);
                  },
                  child: Text(
                    'skip-title'.tr,
                    style: const TextStyle(fontSize: 18, color: Colors.purple),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.rootDelegate.history.clear();
                    Get.rootDelegate.toNamed(Paths.HOME);
                  },
                  child: Text(
                    'viwer-title'.tr,
                    style: const TextStyle(fontSize: 18, color: Colors.purple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      ///text
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 130),
            child: Image.asset(
              'assets/images/intro_1.jpg',
            ),
          ),
          Text(
            'market-title'.tr,
            style: const TextStyle(
                color: Colors.purple,
                fontSize: 26,
                fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 35,
          ),
          Text(
            'topro-title'.tr,
            softWrap: true,
            style: TextStyle(fontSize: 17, color: Colors.purple.shade300),
          ),
        ],
      ),
    );
  }

  PageViewModel interDeliveryPage(context) {
    return PageViewModel(
      decoration:
          const PageDecoration(bodyFlex: 10, bodyPadding: EdgeInsets.zero),

      ///image
      titleWidget: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.rootDelegate.history.clear();
                  Get.rootDelegate.toNamed(Paths.LogIn);
                },
                child: Text(
                  'skip-title'.tr,
                  style: const TextStyle(fontSize: 18, color: Colors.purple),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Get.rootDelegate.history.clear();
                  Get.rootDelegate.toNamed(Paths.HOME);
                },
                child: Text(
                  'viwer-title'.tr,
                  style: const TextStyle(fontSize: 18, color: Colors.purple),
                ),
              ),
            ],
          ),
        ),
      ),

      ///text
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 130),
            child: Image.asset(
              'assets/images/intro_2.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Text(
            'fast-title'.tr,
            style: const TextStyle(
                color: Colors.purple,
                fontSize: 26,
                fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 35,
          ),
          Text(
            'fastde-title'.tr,
            softWrap: true,
            style: TextStyle(fontSize: 17, color: Colors.purple.shade300),
          ),
        ],
      ),
    );
  }

  PageViewModel interPaymentPage(context) {
    return PageViewModel(
      decoration:
          const PageDecoration(bodyFlex: 10, bodyPadding: EdgeInsets.zero),

      ///image
      titleWidget: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.rootDelegate.history.clear();
                  Get.rootDelegate.toNamed(Paths.LogIn);
                },
                child: Text(
                  'skip-title'.tr,
                  style: const TextStyle(fontSize: 18, color: Colors.purple),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Get.rootDelegate.history.clear();
                  Get.rootDelegate.toNamed(Paths.HOME);
                },
                child: Text(
                  'viwer-title'.tr,
                  style: const TextStyle(fontSize: 18, color: Colors.purple),
                ),
              ),
            ],
          ),
        ),
      ),

      ///text
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 130),
            child: Image.asset(
              'assets/images/intro_3.png',
            ),
          ),
          Text(
            'elcpay-title'.tr,
            style: const TextStyle(
                color: Colors.purple,
                fontSize: 26,
                fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 35,
          ),
          Text(
            'thepay-title'.tr,
            softWrap: true,
            style: TextStyle(fontSize: 17, color: Colors.purple.shade300),
          ),
        ],
      ),
    );
  }
}
