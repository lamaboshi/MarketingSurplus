import 'package:marketing_surplus/app/data/model/product.dart';

class SaveProduct {
  Product? product;
  int? amount;
  int? companyId;
  SaveProduct({required this.product, required this.amount});

  SaveProduct.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] == null ? null : Product.fromJson(json['product']);
    amount = json['amount'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['product'] = product?.toJson();
    json['amount'] = amount;
    json['companyId'] = companyId;
    return json;
  }
}
