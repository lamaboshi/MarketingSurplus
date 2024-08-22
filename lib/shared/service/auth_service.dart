import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/data/model/company_product.dart';
import 'package:overlayment/overlayment.dart';

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

  String? personType() => stroge.getData('type') != null
      ? jsonDecode(stroge.getData('type')!).toString()
      : null;
  String companyType() => stroge.containsKey('CompanyType')
      ? jsonDecode(stroge.getData('CompanyType')!).toString()
      : '';
  Auth getTypeEnum() {
    if (personType() == null) return Auth.none;
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
    var result = await _dio.get('/api/CompanyType/Existing',
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
    try {
      var result = await _dio.get('/api/Auth/GetAuth',
          queryParameters: {"email": email, "password": password});
      print(result.data);
      if (result.statusCode == 200) {
        stroge.deleteDataByKey('type');
        stroge.deleteDataByKey('AuthData');

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
    } catch (e) {
      Overlayment.show(OverPanel(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Error LogIn',
            style: TextStyle(
                color: Colors.purple.shade200, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text('There Error With LogIn Please check Again'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Overlayment.dismissLast();
                },
                child: Text(
                  'done'.tr,
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      )));
    }

    return null;
  }

  Future<List<CompanyProduct>> getDataBasket() async {
    if (!stroge.containsKey(key)) return [];
    final data = stroge.getData(key) == null
        ? <CompanyProduct>[]
        : (json.decode(stroge.getData(key)!) as List<dynamic>)
            .map<CompanyProduct>((item) => CompanyProduct.fromJson(item))
            .toList();
    return data;
  }

  Future<List<CompanyProduct>> deleteFromBasket(CompanyProduct product) async {
    //Get All Data
    final list = await getDataBasket();

    //remove To Data
    list.removeWhere((q) => q.product!.id == product.product!.id);

    //Clear Old Data
    if (stroge.containsKey(key)) {
      await stroge.deleteDataByKey(key);
    }
    //Save New Data
    final dataToSave = json.encode(list.map((data) => data.toJson()).toList());

    print(dataToSave);
    stroge.saveData(key, dataToSave);
    return list;
  }

  Future<void> addToBasket(CompanyProduct product) async {
    //Get All Data
    final list = await getDataBasket();
    if (list.any((element) => element.product!.id == product.product!.id)) {
      final item = list
          .where((element) => element.product!.id == product.product!.id)
          .first;
      item.amountApp = item.amountApp! + 1;
      if (item.amountApp! > item.amount!) return;
      await deleteFromBasket(item);
      await addToBasket(item);
      return;
    }

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
