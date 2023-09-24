import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/database_manager.dart';
import 'package:time_tracker/common/routes/app_pages.dart';
import 'package:time_tracker/common/routes/app_routes.dart';
import 'package:time_tracker/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  init() {
    Get.put(DatabaseManager(), permanent: true);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    init();

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
