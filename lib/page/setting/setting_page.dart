import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/routes/app_pages.dart';
import 'package:time_tracker/common/user_manager.dart';

import 'package:time_tracker/page/setting/widget/setting_button.dart';
import "package:time_tracker/page/setting/widget/setting_section.dart";

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  final UserManager userManager = Get.find(tag: "userManager");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 间隔
        const SizedBox(
          height: 100,
        ),
        Section(sectionName: "用户与账户", chidren: [
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: ClipOval(
                  child: Image.network(
                      "https://img2.baidu.com/it/u=1302898461,310300017&fm=253&fmt=auto&app=138&f=JPEG?w=511&h=500"),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                // 左对齐
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("用户名: ${userManager.user?.username}"),
                  const Text("邮箱: 494407383@qq.com"),

                  // 退出登录
                  TextButton(
                      onPressed: () {
                        userManager.logout();
                        Get.offNamed(AppPages.LoginRegister);
                      },
                      child: const Text("退出登录"))
                ],
              ),
            ],
          )
        ]),

        const SizedBox(
          height: 20,
        ),
        Section(
          sectionName: "主题",
          chidren: [
            SettingCardButton(
              text: "明亮模式",
              icon: const Icon(Icons.sunny),
              onPressed: () {},
            ),
            SettingCardButton(
              text: "夜间模式",
              icon: const Icon(Icons.dark_mode),
              onPressed: () {},
            ),
          ],
        ),

        Section(sectionName: "分类管理", chidren: [
          SettingCardButton(
            text: "分类管理",
            icon: const Icon(Icons.category),
            onPressed: () {
              Get.toNamed(AppPages.Category);
            },
          ),
        ])
      ],
    );
  }
}
