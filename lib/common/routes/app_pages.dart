import 'package:get/get.dart';
import 'package:time_tracker/page/Home/view.dart';
import 'package:time_tracker/page/category_manage/add_category.dart';
import 'package:time_tracker/page/login_register/view.dart';
import 'package:time_tracker/page/category_manage/category_event_manage_page.dart';

class AppPages {
  static const home = "/";
  static const loginRegister = "/login_register";
  static const category = "/category";
  static const addCategoryEvent = "/add_category_event_page";

  static final routes = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(
      name: loginRegister,
      page: () => LoginRegisterPage(),
    ),
    GetPage(name: category, page: () => CategoryManagePage()),
    GetPage(name: addCategoryEvent, page: () => AddCategoryEventPage()),
  ];
}
