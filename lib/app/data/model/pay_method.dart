import 'package:marketing_surplus/app/data/model/company.dart';

class PayMethod {
  int? id;
  String? name;
  bool? isAccept;
  PayMethod({this.id, this.name, this.isAccept});

  PayMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isAccept = json['isAccept'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['name'] = name;
    json['isAccept'] = isAccept ?? false;
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
