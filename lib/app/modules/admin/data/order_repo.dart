import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/order_model.dart';
import 'package:marketing_surplus/app/modules/admin/data/adapter/order_adapter.dart';

class OrderDataRepository extends IOrderDataRepository {
  final _dio = Get.find<Dio>();

  @override
  Future<List<OrderModel>> getOrders() async {
    var result = await _dio.get('https://localhost:7092/api/Order/GetOrders');
    print(result);
    var list = <OrderModel>[];
    for (var item in result.data) {
      list.add(OrderModel.fromJson(item));
    }
    return list;
  }
}
