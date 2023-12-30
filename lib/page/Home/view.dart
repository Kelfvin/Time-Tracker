import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:time_tracker/common/user_manager.dart';

import 'package:time_tracker/page/home/home_controller.dart';
import 'package:time_tracker/page/home/widget/my_side_barX.dart';
import 'package:time_tracker/page/home/widget/screen.dart';
import 'package:time_tracker/page/setting/setting_page.dart';
import 'package:time_tracker/widget/framwork/pc_ui_frame.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController =
      Get.put(HomeController(), tag: "homeController");

  HomePage({Key? key}) : super(key: key);

  // 主视图
  @override
  Widget build(BuildContext context) {
    // 进行检验
    // 获取全局的UserManager
    UserManager userManager = Get.find(tag: "userManager");
    userManager.checkLogin();

    return Scaffold(body: PCUIFrame());
  }
}
