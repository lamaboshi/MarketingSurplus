class RestPassword {
  int? id;
  String? type;

  RestPassword({
    this.id,
    this.type,
  });

  RestPassword.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['type'] = type;
    return json;
  }
}
