import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_type.dart';
import 'package:marketing_surplus/app/modules/admin/data/adapter/order_type_adapter.dart';

class OrderTypeRepositry extends IOrderTypeRepositry {
  final _dio = Get.find<Dio>();

  @override
  Future<bool> addOrderType(OrderType orderType) async {
    var result = await _dio.post('/api/OrderType/AddOrderType',
        data: orderType.toJson());
    return result.statusCode == 200;
  }

  @override
  Future<bool> deleteOrderType(int orderTypeId) async {
    var result = await _dio.delete(
      '/api/OrderType/Delete/$orderTypeId',
    );
    return result.statusCode == 200;
  }

  Future<bool> acceptOrderType(int id, bool accept) async {
    var result =
        await _dio.post('/api/OrderType/AcceptOrderType/$id?accept=$accept');
    return result.statusCode == 200;
  }

  @override
  Future<List<OrderType>> getAllOrderType() async {
    var result = await _dio.get('/api/OrderType/GetOrderTypes');
    print(result);
    var list = <OrderType>[];
    for (var item in result.data) {
      list.add(OrderType.fromJson(item));
    }
    return list;
  }

  @override
  Future<bool> updateOrderType(OrderType orderType) async {
    var result = await _dio.put('/api/OrderType/Put/${orderType.id}',
        data: orderType.toJson());
    return result.statusCode == 200;
  }
}
