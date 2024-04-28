import 'dart:typed_data';

class Company {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? password;
  String? telePhone;
  Uint8List? image;
  String? description;

  Company({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.password,
    this.telePhone,
    this.image,
    this.description,
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    password = json['password'];
    telePhone = json['telePhone'];
    description = json['description'];
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
    json['address'] = address;
    json['password'] = password;
    json['telePhone'] = telePhone;
    json['description'] = description;
    json['image'] = image == null ? null : Uint8List.fromList(image!);
    return json;
  }
}
