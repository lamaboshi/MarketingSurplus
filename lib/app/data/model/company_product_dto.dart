import 'package:marketing_surplus/app/data/model/company_type_model.dart';
import 'package:marketing_surplus/app/data/model/subscription.dart';

import 'company_product.dart';

class CompanyProductDto {
  CompanyProduct? companyProduct;
  CompanyTypeModel? type;
  int? rateNumber;
  Subscription? subscription;
  CompanyProductDto({this.companyProduct, this.rateNumber, this.type});
  CompanyProductDto.fromJson(Map<String, dynamic> json) {
    rateNumber = json['rateNumber'] == null
        ? 0
        : int.parse(json['rateNumber'].toString());
    companyProduct = json['companyProduct'] != null
        ? CompanyProduct.fromJson(json['companyProduct'])
        : null;
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
    json['rateNumber'] = rateNumber.toString();
    json['companyType'] = type!.toJson();
    json['subscription'] = subscription!.toJson();
    return json;
  }
}
