import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_tracker/common/controller/user_controller.dart';
import 'package:time_tracker/common/dao/user_dao.dart';
import 'package:time_tracker/common/routes/app_pages.dart';
import 'package:time_tracker/page/category_manage/category_event_manage_page.dart';

import 'package:time_tracker/page/setting/widget/setting_button.dart';
import "package:time_tracker/page/setting/widget/setting_section.dart";

class SettingPage extends StatelessWidget {
  final UserController userController = Get.find();

  final avatarUrl = "".obs;
  SettingPage({Key? key}) : super(key: key) {
    avatarUrl.value =
        "${userController.user.value.avatar!}?t=${DateTime.now().millisecondsSinceEpoch}";
  }

  // late ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                Get.to(Scaffold(
                  appBar: AppBar(),
                  body: CategoryManagePage(),
                ));
              },
            ),
          ])
        ],
      ),
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
              Text("用户名: ${userController.user.value.username}"),
              // 退出登录
              TextButton(
                  onPressed: () {
                    Get.offAllNamed(AppPages.loginRegister);
                    userController.logout();
                  },
                  child: const Text("退出登录"))
            ],
          ),
        ],
      )
    ]);
  }

  void _changeAvatar() async {
    // 使用image_picker
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      if (kDebugMode) {
        print("没有选择图片");
      }
      return;
    }

    if (kDebugMode) {
      print("选择了图片: ${image.path}");
    }

    // 判断文件的大小,不能超过5M

    // 上传图片
    bool success = await UserDao.updateAvatar(image);

    if (success) {
      Get.snackbar("上传成功", "头像已更新");
      // 更新头像
      avatarUrl.value =
          "${userController.user.value.avatar!}?t=${DateTime.now().millisecondsSinceEpoch}";

      if (kDebugMode) {
        print(avatarUrl.value);
      }
    } else {
      Get.snackbar("上传失败", "请稍后再试");
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
    return ClipOval(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
            onTap: () {
              _changeAvatar();
            },
            child: Container(
                color: Colors.grey,
                width: 100,
                height: 100,
                child: Image.network(avatarUrl.value, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person);
                }))));
  }
}
