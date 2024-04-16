import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/modules/first_spalsh/controller/first_splash_page.dart';

class FiestSplashView extends GetView<FirstSplashController> {
  const FiestSplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade200,
      body: Center(
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Obx(() {
              return AnimatedOpacity(
                opacity: controller.opacity.value,
                duration: const Duration(seconds: 4),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              );
            }),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
