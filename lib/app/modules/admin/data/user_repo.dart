import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/user_model.dart';
import 'package:marketing_surplus/app/modules/admin/data/adapter/user_adapter.dart';

class UsersDataRepository extends IUsersDataRepository {
  final _dio = Get.find<Dio>();

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
}
