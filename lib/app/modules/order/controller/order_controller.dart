import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/data/model/order_model.dart';
import 'package:marketing_surplus/app/data/model/order_type.dart';
import 'package:marketing_surplus/app/data/model/pay_method.dart';
import 'package:marketing_surplus/app/data/model/product_donation.dart';
import 'package:marketing_surplus/shared/service/order_service.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../data/model/donation.dart';
import '../../admin/data/pay_method_repo.dart';

class OrderController extends GetxController {
  final order = OrderModel().obs;
  final pays = <CompanyMethods>[].obs;
  final donation = Donation().obs;
  final orderTypes = <OrderType>[].obs;
  final selectedPayMethod = CompanyMethods().obs;
  final selectedType = OrderType().obs;
  final totalPrice = 0.0.obs;
  final keyForm = GlobalKey<FormState>();
  final isProssing = false.obs;
  final selectedArea = 5.obs;
  final colorWay = [
    Colors.purple.shade200.withOpacity(0.6),
    Colors.orange.withOpacity(0.6),
    Colors.blue.withOpacity(0.6)
  ];
  final costs = [15000, 25000, 30000];
  @override
  void onInit() {
    getOrderType();
    getData();
    super.onInit();
  }

  String? forceValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'requird';
    }
    return null;
  }

  Future<void> getData() async {
    totalPrice.value = 0;

    var data = await Get.find<AuthService>().getDataBasket();
    var companyId = data.first.company!.id!;
    await getPayMethod(companyId);
    for (var element in data) {
      var price = element.product!.newPrice ?? 0;
      print((price * element.amountApp!));
      totalPrice.value = totalPrice.value + (price * element.amountApp!);
    }
  }

  Future<void> getOrderType() async {
    final result = await OrderService().getOrderType();
    orderTypes.assignAll(result);
    selectedType.value = orderTypes.first;
  }

  Future<void> getPayMethod(int companyId) async {
    final result = await PayMethodRepositry().getAllMethod(companyId);
    pays.assignAll(result);
    selectedPayMethod.value = pays.first;
  }

  Future<void> saveOrder() async {
    //TODO add userid in order
    var rng = Random().nextInt(10000);

    var data = await Get.find<AuthService>().getDataBasket();
    order.value.name = rng.toString();
    order.value.descripation = order.value.descripation ?? '  ';
    order.value.payMethodId = selectedPayMethod.value.id;
    order.value.price = totalPrice.value;
    order.value.amount = data.length;

    var orderProduct = <OrderProduct>[];
    for (var element in data) {
      var total = element.product!.newPrice! * element.amountApp!;
      orderProduct.add(OrderProduct(
          companyProductId: element.id,
          amount: element.amountApp,
          totalPrice: total.toInt()));
    }

    await OrderService().saveOrder(order.value, orderProduct);
    getData();
    Overlayment.dismissLast();
  }

  Future<void> saveOrderDonation() async {
    var productDonation = <ProductDonation>[];
    print('object');
    var data = await Get.find<AuthService>().getDataBasket();
    donation.value.orderTypeId = selectedType.value.id;
    // 1 for normal
    //2 for donation
    //3 for ACh
    if (donation.value.orderTypeId != 3) {
      for (var element in data) {
        var value = element.product!.newPrice! * element.amountApp!;
        var total = value.toInt();
        productDonation.add(ProductDonation(
            isCompany: false,
            companyProductId: element.id,
            amount: element.amountApp,
            totalPrice: total));
      }
      await OrderService().saveDonation(donation.value, productDonation);
    } else {
      var valueInt2 = int.tryParse(totalPrice.value.toString());
      var valueInt = int.tryParse(donation.value.pricePay.toString());
      if (valueInt2 == valueInt) {
        for (var element in data) {
          var value = element.product!.newPrice! * element.amountApp!;
          var total = value.toInt();
          productDonation.add(ProductDonation(
              isCompany: false,
              companyProductId: element.id,
              amount: element.amountApp,
              totalPrice: total));
        }
        await OrderService().saveDonation(donation.value, productDonation);
      }
    }
    getData();
    Overlayment.dismissLast();
  }
}
