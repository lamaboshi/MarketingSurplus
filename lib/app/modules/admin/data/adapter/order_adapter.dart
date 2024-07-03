import '../../../../data/model/order_Product.dart';

import '../../../../data/model/order_model.dart';

abstract class IOrderDataRepository {
  Future<List<OrderModel>> getOrders();
  Future<List<OrderModel>> getOrdersUser(int userId);
  Future<List<OrderProduct>> getOrderDetails();
}
