import 'package:marketing_surplus/app/data/model/bill.dart';
import 'package:marketing_surplus/app/data/model/order_model.dart';

import 'company_product.dart';

class OrderProduct {
  int? id;
  int? amount;
  int? totalPrice;
  int? companyProductId;
  int? orderId;
  CompanyProduct? companyProduct;
  OrderModel? order;
  List<Bill>? bills;
  OrderProduct({
    this.id,
    this.amount,
    this.totalPrice,
    this.companyProductId,
    this.orderId,
  });

  OrderProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount =
        json['amount'] == null ? null : int.tryParse(json['amount'].toString());
    totalPrice = json['totalPrice'] == null
        ? null
        : int.tryParse(json['totalPrice'].toString());
    companyProductId = json['companyProductId'];
    companyProduct = json['companyProduct'] == null
        ? null
        : CompanyProduct.fromJson(json['companyProduct']);
    order = json['order'] == null ? null : OrderModel.fromJson(json['order']);
    bills = json['bills'] == null
        ? []
        : List<Bill>.from(json['bills'].map<Bill>((i) => Bill.fromJson(i)));
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['amount'] = amount;
    json['totalPrice'] = totalPrice;
    json['companyProductId'] = companyProductId;
    json['orderId'] = orderId;
    return json;
  }
}
