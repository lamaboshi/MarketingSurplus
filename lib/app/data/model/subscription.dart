import 'company.dart';
import 'user_model.dart';

class Subscription {
  int? id;
  Company? company;
  int? companyId;
  int? userId;
  UserModel? user;

  Subscription({
    this.id,
    this.company,
    this.companyId,
    this.userId,
    this.user,
  });

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'] == null
        ? null
        : Company.fromJson(json['company'] as Map<String, dynamic>);
    companyId = json['companyId'];
    userId = json['userId'];
    user = json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? 0;
    data['companyId'] = companyId;
    data['userId'] = userId;
    return data;
  }
}
