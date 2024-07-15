import 'package:marketing_surplus/app/data/model/order_Product.dart';
import 'package:marketing_surplus/app/data/model/order_model.dart';

import 'company_product.dart';

class OrderDto {
  CompanyProduct? companyProduct;
  OrderProduct? orderProduct;
  OrderDto({this.companyProduct, this.orderProduct});
  OrderDto.fromJson(Map<String, dynamic> json) {
    orderProduct = json['orderProduct'] == null
        ? null
        : OrderProduct.fromJson(json['orderProduct'] as Map<String, dynamic>);
    companyProduct = json['companyProduct'] == null
        ? null
        : CompanyProduct.fromJson(
            json['companyProduct'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['orderProduct'] = orderProduct!.toJson();
    json['companyProduct'] = companyProduct!.toJson();

    return json;
  }
}

class OrderDtoToShow {
  OrderModel? order;
  List<OrderProduct>? ordersProduct;
  OrderDtoToShow({this.order, this.ordersProduct});
}
