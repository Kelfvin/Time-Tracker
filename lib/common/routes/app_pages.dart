import 'package:get/get.dart';
import 'package:time_tracker/page/Home/view.dart';
import 'package:time_tracker/page/login_register/view.dart';

class AppPages {
  static const Home = "/";
  static const LoginRegister = "/login_register";

  static final routes = [
    GetPage(name: Home, page: () => HomePage()),
    GetPage(name: LoginRegister, page: () => LoginRegisterPage()),
  ];
}
