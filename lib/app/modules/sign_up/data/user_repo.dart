import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/model/user_model.dart';
import 'adapter/user_adapter.dart';

class UserRepository extends IUserRepository {
  final _dio = Get.find<Dio>();
  @override
  Future<bool> regierterUser(UserModel object) async {
    final map = object.toJson();
    var data =
        await _dio.post('https://localhost:7092/api/User/AddUser', data: map);
    if (data.statusCode == 200) {
      return true;
    } else {
      print(data.statusMessage);
    }
    return false;
  }
}
