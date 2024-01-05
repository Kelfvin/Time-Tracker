import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/user_manager.dart';

import 'package:time_tracker/widget/framwork/pc_ui_frame.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // 全局的UserManager
  final UserManager userManager = Get.find(tag: "userManager");

  // 主视图
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PCUIFrame());
  }
}
