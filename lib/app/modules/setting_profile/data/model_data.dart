class ModelData {
  int? id;
  String? name;
  String? phone;
  String? email;

  ModelData({
    this.id,
    this.name,
    this.phone,
    this.email,
  });

  ModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['phone'] = phone;
    json['email'] = email;
    return json;
  }
}
