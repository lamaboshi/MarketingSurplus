import 'dart:typed_data';

class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  double? oldPrice;
  DateTime? expiration;
  bool? isExpired;
  Uint8List? image;
  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.expiration,
      this.isExpired,
      this.oldPrice,
      this.image});
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    expiration = json['expiration'] == null
        ? null
        : DateTime.tryParse(json['expiration'].toString());
    isExpired = json['isExpired'];
    image = json['image'] == null
        ? null
        : Uint8List.fromList(List<int>.from(json['image']!));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['description'] = description;
    json['price'] = price;
    json['oldPrice'] = oldPrice;
    json['expiration'] = expiration?.toIso8601String();
    json['isExpired'] = isExpired;
    json['image'] = image == null ? null : Uint8List.fromList(image!);
    return json;
  }
}
