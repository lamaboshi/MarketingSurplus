import 'dart:typed_data';

class Charity {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? password;
  Uint8List? image;
  Uint8List? qrCode;
  String? address;
  String? associationLicense;
  String? targetGroup;
  String? goals;

  Charity({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.image,
    this.qrCode,
    this.address,
    this.associationLicense,
    this.targetGroup,
    this.goals,
  });
  Charity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    associationLicense = json['associationLicense'];
    address = json['address'];
    targetGroup = json['targetGroup'];
    password = json['password'];
    goals = json['goals'];
    image = json['image'] == null
        ? null
        : Uint8List.fromList(List<int>.from(json['image']!));
    qrCode = json['qrCode'] == null
        ? null
        : Uint8List.fromList(List<int>.from(json['qrCode']!));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['phone'] = phone;
    json['email'] = email;
    json['goals'] = goals;
    json['address'] = address;
    json['targetGroup'] = targetGroup;
    json['password'] = password;
    json['associationLicense'] = associationLicense;
    json['image'] = image == null ? null : Uint8List.fromList(image!);
    json['qrCode'] = image == null ? null : Uint8List.fromList(qrCode!);

    return json;
  }
}
