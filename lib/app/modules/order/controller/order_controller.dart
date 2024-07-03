import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/data/model/order_model.dart';
import 'package:marketing_surplus/app/data/model/pay_method.dart';
import 'package:marketing_surplus/shared/service/order_service.dart';
import 'package:overlayment/overlayment.dart';

import '../../../../shared/service/auth_service.dart';
import '../../admin/data/pay_method_repo.dart';

class OrderController extends GetxController {
  final order = OrderModel().obs;
  final pays = <PayMethod>[].obs;
  final selectdPayMethod = PayMethod().obs;
  final totalPrice = 0.0.obs;
  @override
  void onInit() {
    getPayMethod();
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

  Future<void> getPayMethod() async {
    final result = await PayMethodRepositry().getAllMethod();
    pays.assignAll(result);
    selectdPayMethod.value = pays.first;
  }

  Future<void> saveOrder() async {
    //TODO add userid in order
    var data = await Get.find<AuthService>().getDataBasket();
    order.value.payMethodId = selectdPayMethod.value.id;
    order.value.price = totalPrice.value;
    order.value.amount = data.length;

    var orderProduct = <OrderProduct>[];
    for (var element in data) {
      var total = element.product!.newPrice! * element.amountApp!;
      orderProduct.add(OrderProduct(
          companyProductId: element.id,
          amount: element.amountApp,
          totalPrice: total));
    }

    await OrderService().saveOrder(order.value, orderProduct);
    Overlayment.dismissLast();
  }
}
