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
  Uint8List? image;

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
    paypal = json['paypal'];
    age = json['age'];
    password = json['password'];
    userName = json['userName'];
    image = json['image'] == null
        ? null
        : Uint8List.fromList(List<int>.from(json['image']!));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['phone'] = phone;
    json['email'] = email;
    json['paypal'] = paypal;
    json['age'] = age;
    json['password'] = password;
    json['userName'] = userName;
    json['image'] = image == null ? null : Uint8List.fromList(image!);
    return json;
  }
}
