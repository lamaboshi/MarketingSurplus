import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/rest_password.dart';
import 'adapter/password_adapter.dart';

class PasswordRepository implements IPasswordRepository {
  final _dio = Get.find<Dio>();

  @override
  Future<RestPassword?> getEmail(String email) async {
    var result =
        await _dio.get('/api/Auth/GetEmail', queryParameters: {"email": email});
    if (result.statusCode == 200) {
      return RestPassword.fromJson(result.data as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<bool> resetPassComp(int idCompany, String newPassword) async {
    var result = await _dio.put('/api/Company/Password',
        queryParameters: {"Id": idCompany, "password": newPassword});
    return result.statusCode == 200;
  }

  @override
  Future<bool> resetPassUser(int idUser, String newPassword) async {
    var result = await _dio.put('/api/User/Password',
        queryParameters: {"Id": idUser, "password": newPassword});
    return result.statusCode == 200;
  }
}
