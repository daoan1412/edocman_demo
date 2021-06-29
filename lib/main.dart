
import 'package:edocman_demo/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    getPages: AppPages.pages,
    initialRoute: Routes.HOME,
  ));
}

