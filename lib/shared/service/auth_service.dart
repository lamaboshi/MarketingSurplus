import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_product.dart';

import '../../api/storge/storge_service.dart';
import '../../app/data/model/charity.dart';
import '../../app/data/model/company.dart';
import '../../app/data/model/company_type_model.dart';
import '../../app/data/model/user_model.dart';
import '../../app/routes/app_routes.dart';

enum Auth { user, comapny, charity, none }

class AuthService {
  final _dio = Get.find<Dio>();
  final stroge = Get.find<StorageService>();
  final key = 'basket-Item';
  bool isAuth() => stroge.containsKey('type');

  String personType() => jsonDecode(stroge.getData('type')!).toString();
  String companyType() => stroge.containsKey('CompanyType')
      ? jsonDecode(stroge.getData('CompanyType')!).toString()
      : '';
  Auth getTypeEnum() {
    switch (personType()) {
      case 'user':
        return Auth.user;
      case 'comapny':
        return Auth.comapny;
      case 'charity':
        return Auth.charity;
    }
    return Auth.none;
  }

  Object? getDataFromStorage() {
    if (stroge.containsKey('AuthData') && stroge.containsKey('type')) {
      var data = jsonDecode(stroge.getData('AuthData')!) as dynamic;
      switch (personType()) {
        case 'user':
          return UserModel.fromJson(data as Map<String, dynamic>);
        case 'comapny':
          return Company.fromJson(data as Map<String, dynamic>);
        case 'charity':
          return Charity.fromJson(data as Map<String, dynamic>);
      }
    }
    return null;
  }

  Future<CompanyTypeModel?> logInType(String type, String password) async {
    var result = await _dio.get(
        'https://localhost:7092/api/CompanyType/Existing',
        queryParameters: {"Type": type, "password": password});
    print(result.data);
    if (result.statusCode == 200) {
      var data = CompanyTypeModel.fromJson(result.data as Map<String, dynamic>);
      stroge.saveData('CompanyType', jsonEncode(data.type!));
      return data;
    }
    return null;
  }

  Future<Object?> logIn(String email, String password) async {
    var result = await _dio.get('https://localhost:7092/api/Auth/GetAuth',
        queryParameters: {"email": email, "password": password});
    print(result.data);
    if (result.statusCode == 200) {
      switch (result.data['type']) {
        case 'user':
          var data =
              UserModel.fromJson(result.data['data'] as Map<String, dynamic>);
          stroge.saveData('type', jsonEncode('user'));
          stroge.saveData('AuthData', jsonEncode(data.toJson()));
          return data;
        case 'comapny':
          var data =
              Company.fromJson(result.data['data'] as Map<String, dynamic>);
          stroge.saveData('type', jsonEncode('comapny'));
          stroge.saveData('AuthData', jsonEncode(data.toJson()));
          return data;
        case 'charity':
          var data =
              Charity.fromJson(result.data['data'] as Map<String, dynamic>);
          stroge.saveData('type', jsonEncode('charity'));
          stroge.saveData('AuthData', jsonEncode(data.toJson()));
          return data;
      }
    }
    return null;
  }

  List<CompanyProduct> getDataBasket() {
    if (!stroge.containsKey(key)) return [];
    return (json.decode(stroge.getData(key)!) as List<dynamic>)
        .map<CompanyProduct>((item) => CompanyProduct.fromJson(item))
        .toList();
  }

  Future<void> deleteFromBasket(CompanyProduct product) async {
    //Get All Data
    final list = getDataBasket();
    //remove To Data
    list.removeWhere((q) => q.productId == product.productId);
    //Clear Old Data
    if (stroge.containsKey(key)) {
      await stroge.deleteDataByKey(key);
    }
    //Save New Data
    final dataToSave = json.encode(list.map((data) => data.toJson()).toList());
    print(dataToSave);
    stroge.saveData(key, dataToSave);
  }

  Future<void> addToBasket(CompanyProduct product) async {
    //Get All Data
    final list = getDataBasket();
    //Add To Data
    list.add(product);
    //Clear Old Data
    if (stroge.containsKey(key)) {
      await stroge.deleteDataByKey(key);
    }
    //Save New Data
    final dataToSave = json.encode(list.map((data) => data.toJson()).toList());
    print(dataToSave);
    stroge.saveData(key, dataToSave);
  }
}

class AuthMiddlware extends GetMiddleware {
  var storge = Get.put(StorageService());
  @override
  RouteSettings? redirect(String? route) => !storge.containsKey('type')
      ? const RouteSettings(name: Paths.Intro)
      : null;
}
