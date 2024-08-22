import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlayment/overlayment.dart';

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
    } else {
      Overlayment.show(OverPanel(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Erorr',
              style: TextStyle(
                  color: Colors.purple.shade200, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Un valid Email'),
          ),
        ],
      )));
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
