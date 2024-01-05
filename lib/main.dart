import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracker/common/routes/app_pages.dart';
import "package:intl/date_symbol_data_local.dart";
import 'package:time_tracker/common/user_manager.dart';

void main() async {
  await initializeDateFormatting('zh_CN', null);

  Get.put(await SharedPreferences.getInstance(), tag: "shared_preferences");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  init() {
    Dio dio = Dio(
      BaseOptions(
          baseUrl: "http://localhost:8080",
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5)),
    );

    Get.put(dio, tag: "dio");

    // 注入全局的UserManager
    Get.put(UserManager(), tag: "userManager");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    init();

    return GetMaterialApp(
      title: '时光迹',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      initialRoute: AppPages.home,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
