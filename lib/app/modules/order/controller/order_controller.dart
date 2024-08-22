import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:marketing_surplus/app/data/model/notification_charity.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/data/model/order_model.dart';
import 'package:marketing_surplus/app/data/model/order_type.dart';
import 'package:marketing_surplus/app/data/model/pay_method.dart';
import 'package:marketing_surplus/app/data/model/product_donation.dart';
import 'package:marketing_surplus/app/data/model/notification.dart' as n;
import 'package:marketing_surplus/app/modules/bills/controller/bills_controller.dart';

import 'package:marketing_surplus/shared/service/order_service.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../../shared/service/notification_service.dart';
import '../../../data/model/donation.dart';

import '../../admin/data/pay_method_repo.dart';
import '../../profile/controller/profile_controller.dart';

class OrderController extends GetxController {
  final order = OrderModel().obs;
  final pays = <CompanyMethods>[].obs;
  final auth = Get.find<AuthService>();
  final donation = Donation().obs;
  final orderTypes = <OrderType>[].obs;
  final selectedPayMethod = CompanyMethods().obs;
  final selectedType = OrderType().obs;
  final totalPrice = 0.0.obs;
  final keyForm = GlobalKey<FormState>();
  final isProssing = false.obs;
  final selectedArea = 5.obs;
  final parc = [25, 40, 50, 75];
  final selectPers = 0.obs;
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
    isProssing.value = false;
    totalPrice.value = 0;
    var data = await Get.find<AuthService>().getDataBasket();
    var companyId = data.first.company!.id!;
    await getPayMethod(companyId);
    for (var element in data) {
      var price = element.product!.newPrice ?? 0;
      print((price * element.amountApp!));
      totalPrice.value = totalPrice.value + (price * element.amountApp!);
    }
    totalPrice.value =
        totalPrice.value + Get.find<BillsController>().totalPriceDetails.value;
  }

  Future<void> getOrderType() async {
    final result = await OrderService().getOrderType();
    orderTypes.assignAll(result);
    selectedType.value = orderTypes.first;
  }

  Future<void> getPayMethod(int companyId) async {
    final result = await PayMethodRepositry().getAllMethod(companyId);
    pays.assignAll(result);
    if (pays.isEmpty) {
      var data = await PayMethodRepositry().addMethod(
          PayMethod(id: 0, name: 'App Account', isAccept: true), companyId);
      if (data) {
        print('**********TOAdd*');
        final result = await PayMethodRepositry().getAllMethod(companyId);
        pays.assignAll(result);
      }
    }
    selectedPayMethod.value = pays.first;
  }

  Future<void> saveOrder() async {
    isProssing.value = true;

    var data = await Get.find<AuthService>().getDataBasket();
    var rng = Random().nextInt(10000);
    order.value.name = 'Order #$rng';
    order.value.descripation = order.value.descripation ?? '  ';
    order.value.payMethodId = selectedPayMethod.value.id;
    order.value.price = totalPrice.value;
    order.value.amount = data.length;
    order.value.createdAt = DateTime.now();
    if (selectedPayMethod.value.payMethodId == 3 ||
        selectedPayMethod.value.payMethod!.name!.trim() ==
            'App Account'.trim()) {
      var account = auth.stroge.getData('account');
      if (account == null || double.parse(account) < totalPrice.value) {
        Overlayment.dismissLast();
        var snackBar = const SnackBar(
            content: Text('You don\'t have Mony place Dispost in Setting'));
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        return;
      }
      auth.stroge.deleteDataByKey('account');
      print('****************Account  ${account}');
      var newAccount = double.parse(account) - totalPrice.value;
      print('****************newAccount  ${newAccount}');
      auth.stroge.saveData('account', newAccount.toString());
    }
    var orderProduct = <OrderProduct>[];
    for (var element in data) {
      var total = element.product!.newPrice! * element.amountApp!;
      orderProduct.add(OrderProduct(
          companyProductId: element.id,
          amount: element.amountApp,
          totalPrice: total.toInt()));
    }
    var result = await OrderService().saveOrder(order.value, orderProduct);
    isProssing.value = false;
    for (var element in result) {
      var notif = n.Notification(
          createdAt: DateTime.now(),
          type: 'User Create',
          isRead: false,
          message:
              'User Create Order Name ${order.value.name} by ProductId $element  for Company: id${data.first.company!.id} name${data.first.company!.name}',
          orderProductId: element);
      await NotificationService().addNotification(notif);
    }
    await Get.find<ProfileController>().getData();
    Overlayment.dismissLast();
  }

  // 1 for normal
  //2 for donation
  //3 for ACh
  Future<void> saveOrderDonation() async {
    isProssing.value = true;
    var productDonation = <ProductDonation>[];
    print('object');
    var data = await Get.find<AuthService>().getDataBasket();
    donation.value.orderTypeId = selectedType.value.id;
    donation.value.createdAt = DateTime.now();

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
      var result =
          await OrderService().saveDonation(donation.value, productDonation);

      for (var element in result) {
        var notif = NotificationCharity(
            createdAt: DateTime.now(),
            type: 'Charity Create',
            isRead: false,
            message:
                'Charity Create OrderType ${selectedType.value.name}  for Company: id${data.first.company!.id} name${data.first.company!.name}',
            productDonationId: element);
        await NotificationService().addNotificationCahrity(notif);
      }
    } else {
      var payTo = (totalPrice.value * (1 - (selectPers.value / 100)));
      donation.value.pricePay = payTo;
      donation.value.percentage = double.tryParse(selectPers.value.toString());
      print(
          'total ${totalPrice.value} pricePay ${donation.value.pricePay}  percentage ${donation.value.percentage}');
      for (var element in data) {
        var value = element.product!.newPrice! * element.amountApp!;
        var total = value.toInt();
        productDonation.add(ProductDonation(
            isCompany: false,
            companyProductId: element.id,
            amount: element.amountApp,
            totalPrice: total));
      }
      var result =
          await OrderService().saveDonation(donation.value, productDonation);
      for (var element in result) {
        var notif = NotificationCharity(
            createdAt: DateTime.now(),
            type: 'Charity Create',
            isRead: false,
            message:
                'Charity Create OrderType ${selectedType.value.name}  for Company: id${data.first.company!.id} name${data.first.company!.name} With percentage ${selectPers.value}%',
            productDonationId: element);
        await NotificationService().addNotificationCahrity(notif);
      }
    }
    isProssing.value = false;
    Overlayment.dismissLast();
    await Get.find<ProfileController>().getData();
  }
}
