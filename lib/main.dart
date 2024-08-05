import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/routes/app_pages.dart';
import 'package:marketing_surplus/generated/locals.g.dart';
import 'package:overlayment/overlayment.dart';

import 'api/storge/storge_service.dart';
import 'shared/service/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var authToken =
        'Basic ' + base64Encode(utf8.encode('11181042:60-dayfreetrial'));

    Get.put(Dio(BaseOptions(
      baseUrl: 'http://automtec-001-site1.htempurl.com',
      headers: {'Authorization': authToken},
      contentType: 'application/json; charset=UTF-8',
    )));
    // Get.put(Dio(BaseOptions(
    //   baseUrl: 'https://localhost:7092',
    // )));
    Overlayment.navigationKey = Get.key;
    var storage = Get.put(StorageService());
    storage.init();
    var local = Locale('en', 'En');
    Get.put(AuthService());
    // if (auth.stroge.containsKey('Local')) {
    //   var data = auth.stroge.getData('Local');
    //   local = data == 'ar' ? Locale('ar', 'AR') : Locale('en', 'En');
    // }

    return GetMaterialApp.router(
        title: "Markting suplus",
        key: key,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        translations: AppTranslation(),
        locale: local,
        getPages: AppPages.routes,
        enableLog: true);
  }
}
