import 'package:marketing_surplus/app/data/model/user_model.dart';

class Notification {
  int? id;
  UserModel? user;
  int? userId;
  String? message;
  String? type;
  DateTime? createdAt;
  bool? isRead;
  Notification({
    this.userId,
    this.message,
    this.type,
    this.isRead,
    this.createdAt,
    this.user,
  });
  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    userId = json['userId'];
    message = json['message'];
    type = json['type'];
    isRead = json['isRead'] ?? false;
    createdAt = json['createdAt'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id ?? 0;
    json['user'] = user?.toJson();
    json['userId'] = userId;
    json['createdAt'] = createdAt;
    json['message'] = message;
    json['type'] = type;
    json['isRead'] = isRead ?? false;
    return json;
  }
}
