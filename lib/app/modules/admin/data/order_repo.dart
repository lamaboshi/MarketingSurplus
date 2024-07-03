import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_model.dart';
import 'package:marketing_surplus/app/data/model/user_model.dart';
import 'package:marketing_surplus/app/modules/admin/data/adapter/order_adapter.dart';
import 'package:marketing_surplus/shared/service/auth_service.dart';

import '../../../data/model/order_Product.dart';

class OrderDataRepository extends IOrderDataRepository {
  final _dio = Get.find<Dio>();

  @override
  Future<List<OrderModel>> getOrders() async {
    var result = await _dio.get('/api/Order/GetOrders');
    print(result);
    var list = <OrderModel>[];
    for (var item in result.data) {
      list.add(OrderModel.fromJson(item));
    }
    return list;
  }

  @override
  Future<List<OrderModel>> getOrdersUser(int userId) async {
    var result = await _dio.get('/api/Order/GetOrdersUser/$userId');
    print(result);
    var list = <OrderModel>[];
    for (var item in result.data) {
      list.add(OrderModel.fromJson(item));
    }
    return list;
  }

  @override
  Future<List<OrderProduct>> getOrderDetails() async {
    final userId =
        (Get.find<AuthService>().getDataFromStorage() as UserModel).id!;

    var result = await _dio.get('/api/Main/GetOrderDetails/$userId');
    print(result);
    var list = <OrderProduct>[];
    for (var item in result.data) {
      list.add(OrderProduct.fromJson(item));
    }
    return list;
  }
}
