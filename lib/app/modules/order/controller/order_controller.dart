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
  final pays = <PayMethod>[].obs;
  final donation = Donation().obs;
  final orderTypes = <OrderType>[].obs;
  final selectedPayMethod = PayMethod().obs;
  final selectedType = OrderType().obs;
  final totalPrice = 0.0.obs;
  @override
  void onInit() {
    getPayMethod();
    getOrderType();
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    totalPrice.value = 0;

    var data = await Get.find<AuthService>().getDataBasket();

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

  Future<void> getPayMethod() async {
    final result = await PayMethodRepositry().getAllMethod();
    pays.assignAll(result);
    selectedPayMethod.value = pays.first;
  }

  Future<void> saveOrder() async {
    //TODO add userid in order
    var data = await Get.find<AuthService>().getDataBasket();
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

    Overlayment.dismissLast();
  }

  Future<void> saveOrderDonation() async {
    var productDonation = <ProductDonation>[];
    var data = await Get.find<AuthService>().getDataBasket();
    donation.value.orderTypeId = selectedType.value.id;
    if (donation.value.orderTypeId != 1) {
      for (var element in data) {
        var value = element.product!.newPrice! * element.amountApp!;
        var total = value.toInt();
        productDonation.add(ProductDonation(
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
              companyProductId: element.id,
              amount: element.amountApp,
              totalPrice: total));
        }
        await OrderService().saveDonation(donation.value, productDonation);
      }
    }

    Overlayment.dismissLast();
  }
}
