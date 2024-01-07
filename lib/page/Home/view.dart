import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/controller/user_controller.dart';


import 'package:time_tracker/widget/framwork/pc_ui_frame.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // 全局的控制器
  final UserController userController = Get.find();

  // 主视图
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PCUIFrame());
  }
}
