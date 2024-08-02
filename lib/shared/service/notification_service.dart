import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/charity.dart';
import 'package:marketing_surplus/app/data/model/notification.dart';
import 'package:marketing_surplus/app/data/model/user_model.dart';

import '../../app/data/model/notification_charity.dart';
import 'auth_service.dart';

class NotificationService {
  final _dio = Get.find<Dio>();
  final auth = Get.find<AuthService>();

  Future<List<Notification>> getNotifications() async {
    var id = (auth.getDataFromStorage() as UserModel).id;

    var data = await _dio.get('/api/Notifications/GetNotifications/$id');
    print(' Notification :$data');
    var list = <Notification>[];
    for (var item in data.data) {
      list.add(Notification.fromJson(item));
    }
    return list;
  }

  Future<List<NotificationCharity>> getNotificationCharity() async {
    var id = (auth.getDataFromStorage() as Charity).id;

    var data = await _dio.get('/api/Notifications/GetNotificationCharity/$id');
    print(' NotificationCharity :$data');
    var list = <NotificationCharity>[];
    for (var item in data.data) {
      list.add(NotificationCharity.fromJson(item));
    }
    return list;
  }

  Future<bool> addNotification(Notification notification) async {
    var result = await _dio.post('/api/Notifications/AddNotification',
        data: notification.toJson());
    return result.statusCode == 200;
  }

  Future<bool> addNotificationCahrity(
      NotificationCharity notificationCharity) async {
    var result = await _dio.post('/api/Notifications/AddNotificationCahrity',
        data: notificationCharity.toJson());
    return result.statusCode == 200;
  }

  Future<bool> markAsRead(int notificationId) async {
    var result =
        await _dio.post('/api/Notifications/MarkAsRead/$notificationId');
    print('----------------Done markAsRead--------------------------');
    return result.statusCode == 200;
  }

  Future<bool> markAsReadCharity(int notificationId) async {
    var result =
        await _dio.post('/api/Notifications/MarkAsReadCharity/$notificationId');
    print('----------------Done markAsReadCharity--------------------------');
    return result.statusCode == 200;
  }
}
