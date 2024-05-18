class OrderType {
  int? id;
  String? name;

  OrderType({
    this.id,
    this.name,
  });

  OrderType.fromJson(Map<String, dynamic> json) {
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
