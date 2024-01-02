import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/user_manager.dart';

import 'package:time_tracker/widget/framwork/pc_ui_frame.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
