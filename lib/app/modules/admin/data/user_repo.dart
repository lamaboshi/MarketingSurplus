import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/user_model.dart';
import 'package:marketing_surplus/app/modules/admin/data/adapter/user_adapter.dart';

class UsersDataRepository extends IUsersDataRepository {
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

  @override
  Future<List<UserModel>> getUsers() async {
    var result = await _dio.get('https://localhost:7092/api/User/GetUser');
    print(result);
    var list = <UserModel>[];
    for (var item in result.data) {
      list.add(UserModel.fromJson(item));
    }
    return list;
  }

  @override
  Future<bool> deleteUser(int id) async {
    var result = await _dio.delete(
      'https://localhost:7092/api/User/Delete/$id',
    );
    return result.statusCode == 200;
  }

  @override
  Future<bool> updateUser(UserModel object) async {
    var result = await _dio.put(
        'https://localhost:7092/api/User/Put/${object.id}',
        data: object.toJson());
    return result.statusCode == 200;
  }
}
