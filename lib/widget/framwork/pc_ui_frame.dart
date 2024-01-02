import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/widget/framwork/pc_ui_frame_controller.dart';

class MaterialIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  /// 高亮颜色
  final Color backgroundColor;

  /// 图标颜色
  final Color iconColor;

  const MaterialIconButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        // 水波纹
        child: SizedBox(
          height: 60,
          width: 80,
          child: Center(
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                size: 17,
                icon,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  final PCUIFrameController sidebarController =
      Get.find(tag: "sidebarController");

  Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: const Color(0xffdee7d6),
          width: 80,
          child: Column(
            children: [
              // 头像
              const SizedBox(
                height: 50,
              ),
              getAvatar(),
              const SizedBox(
                height: 50,
              ),
              for (var button in getIconButtons()) button,
            ],
          ),
        ));
  }

  /// 通过sidebarcontroller 中的 icon 来产生
  List<Widget> getIconButtons() {
    List<Widget> list = [];
    PCUIFrameController.iconMap.forEach((key, value) {
      list.add(
        MaterialIconButton(
          backgroundColor: sidebarController.currentPage.value == key
              ? PCUIFrameController.highlightColors[0]
              : Colors.white,
          iconColor: sidebarController.currentPage.value == key
              ? Colors.white
              : const Color(0xff4a4a4a),
          icon: value,
          text: key,
          onPressed: () {
            sidebarController.setCurrentPage(key);
          },
        ),
      );
    });
    return list;
  }

  /// 生成头像
  Widget getAvatar() {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: NetworkImage("assets/images/avatar.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// PC 和 Web 端的界面框架
class PCUIFrame extends StatelessWidget {
  final PCUIFrameController sidebarController =
      Get.put(PCUIFrameController(), tag: "sidebarController");

  PCUIFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff2f3ea),
      child: Row(
        children: [
          // 左边是侧边栏
          Sidebar(),
          // 右边是主视图
          Body(),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  final PCUIFrameController sidebarController =
      Get.find(tag: "sidebarController");

  Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 3,
                child: Center(child: sidebarController.getCurrentPage()),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ));
  }
}
