class OrderModel {
  int? id;
  String? name;
  int? amount;
  double? price;
  bool? isDelivery;
  int? payMethodId;
  int? userId;
  String? descripation;
  OrderModel({
    this.id,
    this.name,
    this.amount,
    this.price,
    this.isDelivery,
    this.payMethodId,
    this.userId,
    this.descripation,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    price = json['price'];
    isDelivery = json['isDelivery'];
    payMethodId = json['payMethodId'];
    userId = json['userId'];
    descripation = json['descripation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['amount'] = amount;
    json['price'] = price;
    json['isDelivery'] = isDelivery;
    json['payMethodId'] = payMethodId;
    json['telePhone'] = userId;
    json['descripation'] = descripation;
    return json;
  }
}
