import 'package:get/get.dart';
import 'package:time_tracker/page/Home/view.dart';
import 'package:time_tracker/page/category_manage/add_category.dart';
import 'package:time_tracker/page/login_register/view.dart';
import 'package:time_tracker/page/category_manage/category_event_manage_page.dart';

class AppPages {
  static const Home = "/";
  static const LoginRegister = "/login_register";
  static const Category = "/category";
  static const AddCategoryEvent = "/add_category_event_page";

  static final routes = [
    GetPage(name: Home, page: () => HomePage()),
    GetPage(
      name: LoginRegister,
      page: () => LoginRegisterPage(),
    ),
    GetPage(name: Category, page: () => CategoryManagePage()),
    GetPage(name: AddCategoryEvent, page: () => AddCategoryEventPage()),
  ];
}
