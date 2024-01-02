/// 注册登录页面的左边填充部分，用于自适应

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/page/login_register/controller.dart';
import 'package:time_tracker/page/login_register/enum.dart';
import 'package:time_tracker/page/login_register/widgets/login_form.dart';
import 'package:time_tracker/page/login_register/widgets/register_form.dart';

class Body extends StatelessWidget {
  final LoginRegisterController loginRegisterController =
      Get.find(tag: "loginRegisterController");

  Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '记录生活中的\n一点一滴',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "没有账户？",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "试试",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      print(MediaQuery.of(context).size.width);
                    },
                    child: const Text(
                      "注册",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Image.asset(
                'images/illustration-2.png',
                width: 300,
              ),
            ],
          ),
        ),

        Expanded(
          child: Image.asset(
            'images/illustration-1.png',
            width: 300,
          ),
        ),
        // MediaQuery.of(context).size.width >= 1300 //Responsive
        //     ? Image.asset(
        //         'images/illustration-1.png',
        //         width: 300,
        //       )
        //     : SizedBox(),
        Expanded(
          child: Obx(() =>
              loginRegisterController.pageForm.value == PageForm.login
                  ? LoginRegisterForm()
                  : RegisterForm()),
        )
      ],
    );
  }
}
