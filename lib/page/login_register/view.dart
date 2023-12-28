import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/page/login_register/controller.dart';
import 'package:time_tracker/page/login_register/widgets/body.dart';
import 'package:time_tracker/page/login_register/widgets/menu.dart';

class LoginRegisterPage extends StatelessWidget {
  LoginRegisterPage({Key? key}) : super(key: key);
  LoginRegisterController controller =
      Get.put(LoginRegisterController(), tag: "loginRegisterController");

  // 主视图
  Widget _buildView() {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 300),
        children: [
          Menu(),
          // MediaQuery.of(context).size.width >= 980
          //     ? Menu()
          //     : SizedBox(), // Responsive
          Body()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginRegisterController>(
      init: LoginRegisterController(),
      id: "login_register",
      builder: (_) {
        return _buildView();
      },
    );
  }
}
