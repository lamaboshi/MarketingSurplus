import 'package:marketing_surplus/app/data/model/company_type_model.dart';
import 'package:marketing_surplus/app/data/model/subscription.dart';

import 'company_product.dart';
import 'rate.dart' as r;

class CompanyProductDto {
  CompanyProduct? companyProduct;
  CompanyTypeModel? type;
  int? rateNumber;
  List<r.Rate>? rates;
  Subscription? subscription;
  CompanyProductDto(
      {this.companyProduct, this.rateNumber, this.rates, this.type});
  CompanyProductDto.fromJson(Map<String, dynamic> json) {
    rateNumber = json['rateNumber'] == null
        ? 0
        : int.parse(json['rateNumber'].toString());
    companyProduct = json['companyProduct'] != null
        ? CompanyProduct.fromJson(json['companyProduct'])
        : null;
    rates = json['rates'] == null || json['rates'] == [null]
        ? []
        : List<r.Rate>.from(
            json['rates'].map<r.Rate>((i) => r.Rate.fromJson(i)));

    type = json['companyType'] != null
        ? CompanyTypeModel.fromJson(json['companyType'])
        : null;
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['companyProduct'] = companyProduct!.toJson();
    json['rates'] = rates == null || rates!.isEmpty
        ? []
        : rates!.map((e) => e.toJson()).toList();
    json['rateNumber'] = rateNumber?.toString();
    json['companyType'] = type?.toJson();
    json['subscription'] = subscription?.toJson();
    return json;
  }
}
