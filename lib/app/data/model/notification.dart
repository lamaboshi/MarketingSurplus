import 'order_Product.dart';

class Notification {
  int? id;
  OrderProduct? orderProduct;
  int? orderProductId;
  String? message;
  String? type;
  DateTime? createdAt;
  bool? isRead;
  Notification({
    this.orderProductId,
    this.message,
    this.type,
    this.isRead,
    this.createdAt,
    this.orderProduct,
  });
  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    orderProductId = json['orderProductId'];
    message = json['message'];
    type = json['type'];
    isRead = json['isRead'] ?? false;
    createdAt = DateTime.parse(json['createdAt']);
    orderProduct = json['orderProduct'] != null
        ? OrderProduct.fromJson(json['orderProduct'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['orderProduct'] = orderProduct?.toJson();
    json['orderProductId'] = orderProductId;
    json['createdAt'] = createdAt?.toIso8601String();
    json['message'] = message;
    json['type'] = type;
    json['isRead'] = isRead ?? false;
    return json;
  }
}
