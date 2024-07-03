import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_product.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/shared/service/order_service.dart';

import '../../../../shared/service/auth_service.dart';
import '../../admin/data/order_repo.dart';

class BillsController extends GetxController {
  final currentColor = Colors.white.obs;
  final list = <CompanyProduct>[].obs;
  final auth = Get.find<AuthService>();
  Timer? _timer;
  final orderProducts = <OrderProduct>[].obs;
  final orderStatus = OrderStutas.none.obs;
  @override
  void onInit() {
    _startTimer();
    getData();
    getOrder();
    super.onInit();
  }

  Future<void> getOrder() async {
    final result = await OrderDataRepository().getOrderDetails();
    var data = result.where((p0) => p0.bills!.last.orderStatusId != 4);
    orderProducts.assignAll(data);
  }

  Future<void> getData() async {
    list.clear();
    var data = await Get.find<AuthService>().getDataBasket();
    list.assignAll(data);
  }

  Future<void> assignAllAmount() async {
    if (auth.stroge.containsKey('basket-Item')) {
      await auth.stroge.deleteDataByKey('basket-Item');
    }
    final dataToSave = json.encode(list.map((data) => data.toJson()).toList());

    print(dataToSave);

    auth.stroge.saveData('basket-Item', dataToSave);
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
