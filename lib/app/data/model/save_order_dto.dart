import 'dart:convert';

import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/data/model/order_model.dart';

class SaveOrderDto {
  OrderModel? order;
  List<OrderProduct>? orderProducts;
  int? userId;
  SaveOrderDto({required this.order, required this.orderProducts});

  SaveOrderDto.fromJson(Map<String, dynamic> json) {
    order = json['order'] == null ? null : OrderModel.fromJson(json[order]);
    orderProducts = json['orderProducts'] == null
        ? []
        : List<OrderProduct>.from(json['orderProducts']
            .map<OrderProduct>((i) => OrderProduct.fromJson(i)));
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['order'] = order?.toJson();
    json['orderProducts'] =
        jsonEncode(orderProducts!.map((e) => e.toJson()).toList());
    json['userId'] = userId;
    return json;
  }
}
