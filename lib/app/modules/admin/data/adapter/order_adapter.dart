import '../../../../data/model/order_model.dart';

abstract class IOrderDataRepository {
  Future<List<OrderModel>> getOrders();
}
