import 'package:get/get.dart';
import 'package:time_tracker/common/routes/app_routes.dart';
import 'package:time_tracker/page/Home/index.dart';

class AppPages {
  static const INITIAL = AppRoutes.HOME;
  static final routes = [
    GetPage(name: AppRoutes.HOME, page: () => HomePage()),
  ];
}
