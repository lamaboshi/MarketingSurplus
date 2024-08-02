import 'package:marketing_surplus/app/data/model/charity.dart';

class NotificationCharity {
  int? id;
  Charity? charity;
  int? charityId;
  String? message;
  String? type;
  DateTime? createdAt;
  bool? isRead;
  NotificationCharity({
    this.charityId,
    this.message,
    this.type,
    this.isRead,
    this.createdAt,
    this.charity,
  });
  NotificationCharity.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    charityId = json['charityId'];
    message = json['message'];
    type = json['type'];
    isRead = json['isRead'] ?? false;
    createdAt = json['createdAt'];
    charity =
        json['charity'] != null ? Charity.fromJson(json['charity']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['charity'] = charity?.toJson();
    json['charityId'] = charityId;
    json['createdAt'] = createdAt;
    json['message'] = message;
    json['type'] = type;
    json['isRead'] = isRead ?? false;
    return json;
  }
}
