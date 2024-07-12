import 'rate.dart';
import 'subscription.dart';

class Evalution {
  int? id;
  Rate? rate;
  Subscription? subscription;
  int? subscriptionId;
  int? rateId;
  Evalution({this.rate, this.subscription, this.subscriptionId, this.rateId});
  Evalution.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    subscriptionId = json['subscriptionId'];
    rateId = json['rateId'];
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
    rate = json['rate'] != null ? Rate.fromJson(json['rate']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['subscription'] = subscription?.toJson();
    json['subscriptionId'] = subscriptionId;
    json['rateId'] = rateId;
    json['rate'] = rate?.toJson();
    return json;
  }
}
