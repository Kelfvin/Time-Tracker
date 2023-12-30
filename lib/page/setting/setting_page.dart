import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:time_tracker/common/routes/app_pages.dart';
import 'package:time_tracker/common/user_manager.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  UserManager userManager = Get.find(tag: "userManager");

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
                  Text("邮箱: 494407383@qq.com"),

                  // 退出登录
                  TextButton(
                      onPressed: () {
                        userManager.logout();
                        Get.offNamed(AppPages.LoginRegister);
                      },
                      child: Text("退出登录"))
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
            ),
            SettingCardButton(
              text: "夜间模式",
              icon: const Icon(Icons.dark_mode),
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

class SettingCardButton extends StatelessWidget {
  String text = "";

  Icon? icon;

  VoidCallback? onPressed;

  SettingCardButton({super.key, required this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(text),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                icon ?? Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  String sectionName = "";

  List<Widget> chidren = [];

  Section({super.key, required this.sectionName, required this.chidren});

  @override
  Widget build(BuildContext context) {
    return Column(
      // 左对齐
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          sectionName,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),

        // 流式布局
        Wrap(
          spacing: 20,
          children: chidren,
        )
      ],
    );
  }
}
