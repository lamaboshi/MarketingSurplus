import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../app/modules/home/controller/home_controller.dart';

class EmptyBasketController extends GetxController {
  final currentColor = Colors.white.obs;
  Timer? _timer;
  @override
  void onInit() {
    _startTimer();
    super.onInit();
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      currentColor.value = currentColor.value == Colors.white
          ? Colors.purple.shade200
          : Colors.white;
    });
  }
}

class EmptyBasket extends GetView<EmptyBasketController> {
  const EmptyBasket({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 20,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: SizedBox(
              height: Get.height / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Obx(
                    () => Icon(
                      Icons.shopping_bag,
                      color: controller.currentColor.value,
                      size: 65,
                    ),
                  )),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'baskt-title-em'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          'baskt-title-cho'.tr,
                        ),
                        Text(
                          'baskt-title-cho1'.tr,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.find<HomeController>().pageIndex.value = 1;
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple.shade200,
                            shape: const StadiumBorder()),
                        child: SizedBox(
                          width: 150,
                          height: 50,
                          child: Center(
                            child: Text(
                              'find-title'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyOrder extends GetView {
  const EmptyOrder({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: SizedBox(
          height: Get.height / 5,
          width: Get.width - 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.hourglass_empty,
                  size: 35,
                ),
              ),
              Text(
                'dontord-title'.tr,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.find<HomeController>().pageIndex.value = 1;
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade200,
                      shape: const StadiumBorder()),
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: Center(
                      child: Text(
                        'find-title'.tr,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyData extends GetView {
  const EmptyData({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'nodat-title'.tr,
            style: TextStyle(color: Colors.purple.shade200, fontSize: 19),
          ),
          const SizedBox(
            height: 10,
          ),
          Icon(
            Icons.do_disturb_alt_outlined,
            size: 45,
            color: Colors.purple.shade200,
          )
        ],
      ),
    ));
  }
}
