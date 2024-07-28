import 'package:marketing_surplus/app/data/model/company.dart';
import 'package:marketing_surplus/app/data/model/product.dart';

class CompanyProduct {
  int? id;
  Company? company;
  Product? product;

  int? productId;
  int? companyId;
  int? rateNumber;
  int? amount;
  int? amountApp;
  CompanyProduct({this.company, this.rateNumber, this.product, this.amount});
  CompanyProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rateNumber = json['rateNumber'] == null
        ? null
        : int.parse(json['rateNumber'].toString());

    amount = json['amount'] == null ? 0 : int.parse(json['amount'].toString());
    amountApp =
        json['amountApp'] == null ? 1 : int.parse(json['amountApp'].toString());
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['company'] = company?.toJson();
    json['companyId'] = companyId;

    json['productId'] = productId;
    json['product'] = product?.toJson();
    json['rateNumber'] = rateNumber?.toString();
    json['amount'] = amount.toString();
    json['amountApp'] = amountApp.toString();
    return json;
  }
}
