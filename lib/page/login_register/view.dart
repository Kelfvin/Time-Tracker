import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/page/login_register/controller.dart';
import 'package:time_tracker/page/login_register/enum.dart';
import 'package:time_tracker/page/login_register/widgets/body.dart';
import 'package:time_tracker/page/login_register/widgets/login_form.dart';
import 'package:time_tracker/page/login_register/widgets/menu.dart';
import 'package:time_tracker/page/login_register/widgets/register_form.dart';

class LoginRegisterPage extends StatelessWidget {
  LoginRegisterPage({Key? key}) : super(key: key);
  final LoginRegisterController loginRegisterController = Get.put(
    LoginRegisterController(),
  );

  Widget _buildPhoneView() {
    Widget form = loginRegisterController.pageForm.value == PageForm.login
        ? LoginRegisterForm()
        : RegisterForm();

    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: form,
          ),
        ],
      ),
    );
  }

  // 主视图
  Widget _buildView() {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 300),
        children: [
          const Menu(),
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
    return GetPlatform.isMobile ? Obx(() => _buildPhoneView()) : _buildView();
  }
}
