import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_tracker/common/dao/user_dao.dart';
import 'package:time_tracker/common/routes/app_pages.dart';
import 'package:time_tracker/common/user_manager.dart';

import 'package:time_tracker/page/setting/widget/setting_button.dart';
import "package:time_tracker/page/setting/widget/setting_section.dart";

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  final UserManager userManager = Get.find(tag: "userManager");

  /// 保存图片图片更换需要使用
  // late ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 间隔
        const SizedBox(
          height: 100,
        ),
        Obx(() => _buildUserInfoSection()),

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
              Get.toNamed(AppPages.category);
            },
          ),
        ])
      ],
    );
  }

  Section _buildUserInfoSection() {
    return Section(sectionName: "用户与账户", chidren: [
      Row(
        children: [
          _buildAvatar(),
          const SizedBox(
            width: 20,
          ),
          Column(
            // 左对齐
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("用户名: ${userManager.user.value.username}"),
              Text("${userManager.user.value.avatar}"),

              // 退出登录
              TextButton(
                  onPressed: () {
                    userManager.logout();
                    Get.offNamed(AppPages.loginRegister);
                  },
                  child: const Text("退出登录"))
            ],
          ),
        ],
      )
    ]);
  }

  void _changeAvatar() async {
    print("更换头像");

    // 使用image_picker
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      print("没有选择图片");
      return;
    }

    print("选择了图片: ${image.path}");

    // 上传图片
    bool success = await UserDao.updateAvatar(image);

    if (success) {
      print("上传成功");

      userManager.avatarKey.value = UniqueKey();
    } else {
      print("上传失败");
    }
  }

  /// 更换头像的一个对话框
  /// 中间是一个图片显示和选择按钮
  /// 项目是确实和取消按钮
  /// 点击确定按钮，就会上传图片
  // void _showChangeAvatarDialog() {
  //   Get.defaultDialog(
  //     title: "更换头像",
  //     content: Column(
  //       children: [
  //         // 图片
  //         Container(
  //           width: 200,
  //           height: 200,
  //           color: Colors.grey,
  //           child: CachedNetworkImage(
  //             // 扩展到最大
  //             fit: BoxFit.cover,
  //             useOldImageOnUrlChange: false,
  //             // 不保存在内存中
  //             key: UniqueKey(),
  //             imageUrl: userManager.user.value.avatar ?? "",
  //             placeholder: (context, url) => const CircularProgressIndicator(),
  //             errorWidget: (context, url, error) =>
  //                 // 默认头像
  //                 const Icon(Icons.person),
  //           ),
  //         ),
  //         // 选择按钮
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             TextButton(
  //                 onPressed: () {
  //                   _changeAvatar();
  //                 },
  //                 child: const Text("选择图片")),
  //           ],
  //         )
  //       ],
  //     ),
  //     textConfirm: "确定",
  //     textCancel: "取消",
  //   );
  // }

  /// 头像组件
  Widget _buildAvatar() {
    return Obx(() => ClipOval(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {
            _changeAvatar();
          },
          child: Container(
            color: Colors.grey,
            width: 100,
            height: 100,
            child: CachedNetworkImage(
              useOldImageOnUrlChange: false,
              // 不保存在内存中
              key: userManager.avatarKey.value,
              imageUrl: userManager.user.value.avatar ?? "",
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  // 默认头像
                  const Icon(Icons.person),
            ),
          ),
        )));
  }
}
