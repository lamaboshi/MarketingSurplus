class Rate {
  int? id;
  int? rateNumber;
  String? description;
  Rate({this.id, this.rateNumber, this.description});

  Rate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rateNumber = json['rateNumber'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['rateNumber'] = rateNumber;
    json['description'] = description;
    return json;
  }
}
