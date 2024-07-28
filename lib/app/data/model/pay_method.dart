import 'package:marketing_surplus/app/data/model/company.dart';

class PayMethod {
  int? id;
  String? name;

  PayMethod({
    this.id,
    this.name,
  });

  PayMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['name'] = name;
    return json;
  }
}

class CompanyMethods {
  int? id;
  PayMethod? payMethod;
  Company? company;
  int? payMethodId;
  int? companyId;
  CompanyMethods(
      {this.payMethod, this.payMethodId, this.companyId, this.company});
  CompanyMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    payMethodId = json['payMethodId'];
    companyId = json['companyId'];
    payMethod = json['payMethod'] != null
        ? PayMethod.fromJson(json['payMethod'])
        : null;
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['company'] = company?.toJson();
    json['companyId'] = companyId;
    json['payMethodId'] = payMethodId;
    json['payMethod'] = payMethod?.toJson();
    return json;
  }
}
