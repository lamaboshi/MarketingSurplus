import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_product.dart';

import '../../../../shared/service/auth_service.dart';

class BillsController extends GetxController {
  final currentColor = Colors.white.obs;
  final list = <CompanyProduct>[].obs;
  Timer? _timer;
  @override
  void onInit() {
    _startTimer();
    getData();
    super.onInit();
  }

  void getData() {
    list.clear();
    var data = Get.find<AuthService>().getDataBasket();
    list.assignAll(data);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentColor.value =
          currentColor.value == Colors.white ? Colors.purple : Colors.white;
    });
  }
}
