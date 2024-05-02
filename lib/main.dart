import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/routes/app_pages.dart';
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
    Get.put(Dio());
    Overlayment.navigationKey = Get.key;
    var storge = Get.put(StorageService());
    storge.init();
    Get.put(AuthService());
    return GetMaterialApp.router(
        title: "Markting suplus",
        key: key,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        getPages: AppPages.routes,
        enableLog: true);
  }
}
