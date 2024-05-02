class CompanyTypeModel {
  int? id;
  String? type;
  String? description;

  CompanyTypeModel({this.id, this.type, this.description});

  CompanyTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['typeName'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['typeName'] = type;
    json['description'] = description;
    return json;
  }
}
