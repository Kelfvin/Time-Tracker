import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:time_tracker/page/grid_page/time_grid_page.dart';
import 'package:time_tracker/page/setting/setting_page.dart';
import 'package:time_tracker/widget/analys/statistic.dart';

class ScreensExample extends StatelessWidget {
  ScreensExample({
    Key? key,
  }) : super(key: key);

  SidebarXController controller = Get.find(tag: "sidebarXController");

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
