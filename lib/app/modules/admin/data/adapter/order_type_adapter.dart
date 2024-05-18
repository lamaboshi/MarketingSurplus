import '../../../../data/model/order_type.dart';

abstract class IOrderTypeRepositry {
  Future<List<OrderType>> getAllOrderType();
  Future<bool> addOrderType(OrderType orderType);
  Future<bool> updateOrderType(OrderType orderType);
  Future<bool> deleteOrderType(int orderTypeId);
}
