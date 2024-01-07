import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracker/common/controller/category_controller.dart';
import 'package:time_tracker/common/controller/record_controller.dart';
import 'package:time_tracker/common/controller/user_controller.dart';
import 'package:time_tracker/common/routes/app_pages.dart';
import "package:intl/date_symbol_data_local.dart";

void main() async {
  await initializeDateFormatting('zh_CN', null);

  Get.put(await SharedPreferences.getInstance());

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

    Get.put(dio);

    UserController userController = Get.put(UserController());
    // 注入拦截器
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 如果有token，就添加到请求头
        if (userController.token.value != "") {
          options.headers["Authorization"] = userController.token.value;
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        // 如果token过期，就跳转到登录页面
        if (response.data["code"] == 400) {
          userController.logout();
          Get.offAllNamed(AppPages.loginRegister);
        }
        return handler.next(response);
      },
    ));

    // 注入类型
    Get.put(CategoryController());

    // 注入recordController
    Get.put(RecordController());
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
