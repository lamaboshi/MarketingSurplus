import 'user_model.dart';

class OrderModel {
  int? id;
  String? name;
  int? amount;
  double? price;
  bool? isDelivery;
  int? payMethodId;
  DateTime? createdAt;
  int? userId;
  UserModel? user;
  String? descripation;
  OrderModel({
    this.id,
    this.name,
    this.amount,
    this.price,
    this.isDelivery = false,
    this.payMethodId,
    this.userId,
    this.createdAt,
    this.user,
    this.descripation,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    createdAt = DateTime.parse(json['createdAt']);
    price = json['price'] == null
        ? null
        : double.tryParse(json['price'].toString());
    user = json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>);
    isDelivery = json['isDelivery'];
    payMethodId = json['payMethodId'];
    userId = json['userId'];
    descripation = json['descripation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['name'] = name;
    json['amount'] = amount;
    json['price'] = price;
    json['isDelivery'] = isDelivery;
    json['payMethodId'] = payMethodId;
    json['userId'] = userId;
    json['createdAt'] = createdAt?.toIso8601String();
    json['descripation'] = descripation;
    return json;
  }
}
