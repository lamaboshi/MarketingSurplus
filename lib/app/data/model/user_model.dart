import 'dart:typed_data';

class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? paypal;
  int? age;
  String? password;
  String? userName;
  String? address;
  Uint8List? image;
  Uint8List? qRCode;
  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.paypal,
    this.age,
    this.password,
    this.userName,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    paypal = json['payPal'];
    address = json['address'];
    age = json['age'];
    password = json['password'];
    userName = json['userName'];
    image = json['image'] == null
        ? null
        : Uint8List.fromList(List<int>.from(json['image']!));
    qRCode = json['qrCode'] == null
        ? null
        : Uint8List.fromList(List<int>.from(json['qrCode']!));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['phone'] = phone;
    json['email'] = email;
    json['payPal'] = paypal;
    json['address'] = address;
    json['age'] = age;
    json['password'] = password;
    json['userName'] = userName;
    json['image'] = image == null ? null : Uint8List.fromList(image!);
    json['qrCode'] = image == null ? null : Uint8List.fromList(qRCode!);

    return json;
  }
}
