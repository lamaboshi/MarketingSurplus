import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:marketing_surplus/app/routes/app_routes.dart';

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
        done: Text("Done".tr,
            style: const TextStyle(
                color: Colors.purple, fontWeight: FontWeight.w600)),
        showNextButton: true,
        showBackButton: true,
        showSkipButton: false,
        onDone: () {
          Get.rootDelegate.toNamed(Paths.SignUpUserPage);
        },
        back: Text("Back".tr,
            style: const TextStyle(
                color: Colors.purple, fontWeight: FontWeight.w600)),
        next: Text("Next".tr,
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
}

PageViewModel interProductPage(context) {
  return PageViewModel(
    decoration:
        const PageDecoration(bodyFlex: 10, bodyPadding: EdgeInsets.zero),

    ///image
    titleWidget: Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: InkWell(
          onTap: () {
            Get.rootDelegate.toNamed(Paths.LogIn);
          },
          child: const Text(
            'Log In',
            style: TextStyle(fontSize: 18, color: Colors.purple),
          ),
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
            'assets/images/intro_1.jpg',
          ),
        ),
        const Text(
          'Marketing surplus products',
          style: TextStyle(
              color: Colors.purple, fontSize: 26, fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 35,
        ),
        Text(
          'To protect surplus products from wastage',
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
        child: InkWell(
          onTap: () {
            Get.rootDelegate.toNamed(Paths.LogIn);
          },
          child: const Text(
            'Log In',
            style: TextStyle(fontSize: 18, color: Colors.purple),
          ),
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
        const Text(
          'Fast delivery',
          style: TextStyle(
              color: Colors.purple, fontSize: 26, fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 35,
        ),
        Text(
          'Fast delivery to your home to save time and effort',
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
        child: InkWell(
          onTap: () {
            Get.rootDelegate.toNamed(Paths.LogIn);
          },
          child: const Text(
            'Log In',
            style: TextStyle(fontSize: 18, color: Colors.purple),
          ),
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
        const Text(
          'Electronic payment',
          style: TextStyle(
              color: Colors.purple, fontSize: 26, fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 35,
        ),
        Text(
          'The payment process is secure and confidential',
          softWrap: true,
          style: TextStyle(fontSize: 17, color: Colors.purple.shade300),
        ),
      ],
    ),
  );
}
