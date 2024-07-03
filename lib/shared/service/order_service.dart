import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_model.dart';

import '../../api/storge/storge_service.dart';
import '../../app/data/model/order_Product.dart';
import '../../app/data/model/user_model.dart';
import 'auth_service.dart';

enum OrderStutas { none, waitingAccepte, accepted, preparation, done }

class OrderService {
  final _dio = Get.find<Dio>();
  final stroge = Get.find<StorageService>();
  final auth = Get.find<AuthService>();
  final orderKay = 'order';
  final orderTypeKay = 'orderType';
  bool inOrder() => stroge.containsKey(orderKay);
  bool inorderType() => stroge.containsKey(orderTypeKay);
  OrderStutas? getOrderStutas() {
    if (stroge.getData(orderTypeKay) != null) {
      final name = jsonDecode(stroge.getData(orderTypeKay)!).toString();
      return OrderStutas.values.where((element) => element.name == name).first;
    }
    return null;
  }

  OrderModel? getOrderFromStorage() {
    if (stroge.containsKey(orderKay)) {
      var data = jsonDecode(stroge.getData(orderKay)!) as dynamic;
      return OrderModel.fromJson(data as Map<String, dynamic>);
    }
    return null;
  }

  Future<bool> saveOrder(
      OrderModel order, List<OrderProduct> orderProduct) async {
    if (auth.getTypeEnum() == Auth.user) {
      final userId = (auth.getDataFromStorage() as UserModel).id!;
      order.userId = userId;
    }
    print(order.toJson());
    var data = await _dio.post('/api/Main/SaveOrder', data: order.toJson());
    if (data.statusCode == 200) {
      print('****************** add order');
      final orderId = int.parse(data.data.toString());
//ToAddAll Products
      for (var element in orderProduct) {
        element.orderId = orderId;
        await _dio.post('/api/Main/SaveOrderProduct', data: element.toJson());
        print('****************** add Product');
      }

      //TOSaveOrder
      final order = await getOrder(orderId);
      stroge.saveData(
          orderTypeKay, jsonEncode(OrderStutas.waitingAccepte.name));
      stroge.saveData(orderKay, jsonEncode(order.toJson()));
      const key = 'basket-Item';
      stroge.deleteDataByKey(key);

      return true;
    } else {
      print(data.statusMessage);
    }
    return false;
  }

  Future<OrderModel> getOrder(int id) async {
    var result = await _dio.get('/api/Order/Get/$id');
    print(result);
    return OrderModel.fromJson(result.data as Map<String, dynamic>);
  }
}
