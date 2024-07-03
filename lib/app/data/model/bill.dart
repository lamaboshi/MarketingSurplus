class Bill {
  int? id;
  String? note;
  int? orderProductId;
  int? orderStatusId;
  Bill({
    this.id,
    this.note,
    this.orderProductId,
    this.orderStatusId,
  });

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'] ?? json['note'].toString();
    orderProductId = json['orderProductId'];
    orderStatusId = json['orderStatusId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['note'] = note;
    json['orderProductId'] = orderProductId;
    json['orderStatusId'] = orderStatusId;
    return json;
  }
}
