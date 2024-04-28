import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketing_surplus/app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
        title: "Markting suplus",
        key: key,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        getPages: AppPages.routes,
        enableLog: true);
  }
}
