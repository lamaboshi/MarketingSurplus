import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_product.dart';
import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/shared/service/order_service.dart';

import '../../../../shared/service/auth_service.dart';
import '../../../data/model/order_type.dart';
import '../../../data/model/product_donation.dart';
import '../../admin/data/order_repo.dart';

class BillsController extends GetxController {
  final list = <CompanyProduct>[].obs;
  final orderTypes = <OrderType>[].obs;
  final auth = Get.find<AuthService>();

  final orderProducts = <OrderProduct>[].obs;
  final lastOrderCharity = <ProductDonation>[].obs;
  final orderStatus = OrderStutas.none.obs;
  @override
  void onInit() {
    getData();
    getOrderType();
    super.onInit();
  }

  Future<void> getOrder() async {
    final result = await OrderDataRepository().getOrderDetails();
    orderProducts.assignAll(result);
    print('data in Bills ${result.length}');
  }

  Future<void> getOrderType() async {
    final result = await OrderService().getOrderType();
    orderTypes.assignAll(result);
  }

  Future<void> getData() async {
    list.clear();
    var data = await Get.find<AuthService>().getDataBasket();
    list.assignAll(data);

    if (auth.getTypeEnum() == Auth.user) {
      await getOrder();
    } else if (auth.getTypeEnum() == Auth.charity) {
      await getLastOrderCharity();
    }
  }

  Future<void> getLastOrderCharity() async {
    final result = await OrderService().getAllDonation();
    lastOrderCharity.assignAll(result);
    print(
        '----------------getLastOrderCharity from bill with ${lastOrderCharity.length}-----------');
  }

  Future<void> assignAllAmount() async {
    if (auth.stroge.containsKey('basket-Item')) {
      await auth.stroge.deleteDataByKey('basket-Item');
    }
    final dataToSave = json.encode(list.map((data) => data.toJson()).toList());

    print(dataToSave);

    auth.stroge.saveData('basket-Item', dataToSave);
  }
}
