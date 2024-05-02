class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  DateTime? expiration;
  bool? isExpired;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.expiration,
    this.isExpired,
  });
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    expiration = json['expiration'];
    isExpired = json['isExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['description'] = description;
    json['price'] = price;
    json['expiration'] = expiration;
    json['isExpired'] = isExpired;
    return json;
  }
}
