class OrderType {
  int? id;
  String? name;
  bool? isAccept;
  OrderType({this.id, this.name, this.isAccept});

  OrderType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isAccept = json['isAccept'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['name'] = name;
    json['isAccept'] = isAccept;
    return json;
  }
}
