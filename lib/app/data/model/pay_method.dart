class PayMethod {
  int? id;
  String? name;

  PayMethod({
    this.id,
    this.name,
  });

  PayMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['name'] = name;
    return json;
  }
}
