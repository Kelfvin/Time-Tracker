import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:time_tracker/page/timegrid/time_grid_page.dart';
import 'package:time_tracker/page/setting/setting_page.dart';
import 'package:time_tracker/widget/analys/statistic.dart';


/// 主视图,侧边栏旁边的那部分，用于显示各个页面
class Screen extends StatelessWidget {
  Screen({
    Key? key,
  }) : super(key: key);

  SidebarXController controller = Get.find(tag: "sidebarXController");

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        Widget screen = _getWigetByIndex(controller.selectedIndex);

        return screen;
      },
    );
  }
}

_getWigetByIndex(int selectedIndex) {
  switch (selectedIndex) {
    case 0:
      return TimeGridPage();
    case 1:
      return Statistic();

    case 2:
      return SettingPage();
    default:
      return TimeGridPage();
  }
}
