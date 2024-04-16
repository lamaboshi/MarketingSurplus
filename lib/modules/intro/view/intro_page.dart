import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../controller/intro_controller.dart';

class IntroPage extends GetView<IntroController> {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          interPage(context),
          interInfluncerPage(context),
          interCompanyPage(context)
        ],
        done: Text("Done".tr,
            style: const TextStyle(
                color: Colors.purple, fontWeight: FontWeight.w600)),
        showNextButton: true,
        showBackButton: true,
        showSkipButton: false,
        onDone: () {},
        back: Text("Back".tr,
            style: const TextStyle(
                color: Colors.purple, fontWeight: FontWeight.w600)),
        next: Text("Next".tr,
            style: const TextStyle(
                color: Colors.purple, fontWeight: FontWeight.w600)),
        globalBackgroundColor: Colors.white,
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Colors.purple,
          activeColor: Colors.purple,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}

//interpage
PageViewModel interPage(context) {
  return PageViewModel(
    decoration:
        const PageDecoration(bodyFlex: 10, bodyPadding: EdgeInsets.zero),

    ///image
    titleWidget: const Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          'Log In',
          style: TextStyle(fontSize: 18, color: Colors.purple),
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

//inter Influncer page
PageViewModel interInfluncerPage(context) {
  return PageViewModel(
    decoration:
        const PageDecoration(bodyFlex: 10, bodyPadding: EdgeInsets.zero),

    ///image
    titleWidget: const Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          'Log In',
          style: TextStyle(fontSize: 18, color: Colors.purple),
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

//inter company page
PageViewModel interCompanyPage(context) {
  return PageViewModel(
    decoration:
        const PageDecoration(bodyFlex: 10, bodyPadding: EdgeInsets.zero),

    ///image
    titleWidget: const Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          'Log In',
          style: TextStyle(fontSize: 18, color: Colors.purple),
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

//inter user page
PageViewModel interUserPage(context) {
  final height = MediaQuery.of(context).size.height / 2;
  return PageViewModel(
    decoration: const PageDecoration(
      pageColor: Colors.white,
      imagePadding: EdgeInsets.fromLTRB(20, 35, 20, 20),
      imageFlex: 0,
      titlePadding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      contentMargin: EdgeInsets.all(20),
      footerPadding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      imageAlignment: Alignment.topLeft,
      bodyFlex: 0,
      bodyAlignment: Alignment.center,
      bodyPadding: EdgeInsets.fromLTRB(0, 20, 0, 20),
    ),
    image: Text('BeUser'.tr,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 45.0)),

    ///image
    titleWidget: Center(
      child: Image.asset(
        'assets/images/user.gif',
        height: height * 1.25 / 3,
      ),
    ),

    ///text
    bodyWidget: Text('theuserfollowscopaniesandcontentmakers'.tr),

    footer: Column(
      children: [
        ///btn Sign Up As User
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange),
              fixedSize: MaterialStateProperty.all(Size.fromWidth(height)),
            ),
            onPressed: () {
              // Get.rootDelegate.offNamed(Routes.SignUpUserPage);
            },
            child: Text(
              "SignUpAsUser".tr,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),

        ///you Have Account? sign in
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('youHaveAccount?'.tr,
                style: const TextStyle(
                  color: Colors.grey,
                )),
            const SizedBox(
              width: 3,
            ),
            InkWell(
              child: Text(
                'signin'.tr,
                style: const TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () {
                //    Get.rootDelegate.offNamed(Routes.SignIn);
              },
            ),
          ],
        ),
      ],
    ),
  );
}
