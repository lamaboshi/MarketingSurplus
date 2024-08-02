import 'dart:typed_data';

class Product {
  int? id;
  String? name;
  String? descripation;
  double? newPrice;
  double? oldPrice;
  DateTime? expiration;
  String? onlineImage;
  DateTime? dateTime;
  bool? isExpiration;
  Uint8List? image;
  Product(
      {this.id,
      this.name,
      this.descripation,
      this.newPrice,
      this.expiration,
      this.dateTime,
      this.isExpiration,
      this.oldPrice,
      this.image});
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    onlineImage = json['onlineImage'];
    descripation = json['descripation'];
    newPrice = json['newPrice'] == null
        ? null
        : double.tryParse(json['newPrice'].toString());
    oldPrice = json['oldPrice'] == null
        ? null
        : double.tryParse(json['oldPrice'].toString());
    expiration = json['expiration'] == null
        ? null
        : DateTime.tryParse(json['expiration'].toString());
    dateTime = json['dateTime'] == null
        ? null
        : DateTime.tryParse(json['dateTime'].toString());
    isExpiration = json['isExpiration'];
    image = json['image'] == null
        ? null
        : Uint8List.fromList(List<int>.from(json['image']!));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['name'] = name;
    json['descripation'] = descripation;
    json['newPrice'] = newPrice;
    json['oldPrice'] = oldPrice;
    json['dateTime'] = dateTime?.toIso8601String();
    json['expiration'] = expiration?.toIso8601String();
    json['isExpiration'] = isExpiration;
    json['onlineImage'] = onlineImage;
    json['image'] =
        image == null || image!.isEmpty ? null : Uint8List.fromList(image!);
    return json;
  }
}
