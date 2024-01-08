import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/page/activity/activity_page.dart';
import 'package:time_tracker/page/category_manage/category_event_manage_page.dart';
import 'package:time_tracker/page/group/group_page.dart';
import 'package:time_tracker/page/setting/setting_page.dart';
import 'package:time_tracker/page/time_line/time_line_page.dart';
import 'package:time_tracker/page/statistic/view.dart';

class PCUIFrameController extends GetxController {
  // 当前选中的页面
  var currentPage = TIMELINE.obs;

  // ignore: constant_identifier_names
  static const TIMELINE = "TimeLine";

  // ignore: constant_identifier_names
  static const SETTING = "Setting";

  // ignore: constant_identifier_names
  static const STATISTIC = "Statistic";

  // ignore: constant_identifier_names
  static const CATEGORY = "Category";

  // ignore: constant_identifier_names
  static const ACTIVITY = "Activity";

  // ignore: constant_identifier_names
  static const GROUP = "Group";

  ///高亮颜色
  static const List<Color> highlightColors = [
    Color(0xff2eaefd),
    Color(0xff41e28c),
    Color(0xfff66c89),
    Color(0xfffdc33f),
    Color(0xffa25ddc),
  ];

  // 页面到Icon的映射
  static Map<String, IconData> iconMap = {
    TIMELINE: Icons.timeline,
    ACTIVITY: Icons.access_time,
    STATISTIC: Icons.bar_chart,
    CATEGORY: Icons.category,
    GROUP: Icons.group,
    SETTING: Icons.settings,
  };

  // 类别到构造一个页面的函数的映射，返回一个Widget
  static Map<String, Widget Function()> pageMap = {
    TIMELINE: () => TimeLinePage(),
    SETTING: () => SettingPage(),
    STATISTIC: () => StatisticPage(),
    CATEGORY: () => CategoryManagePage(),
    ACTIVITY: () => ActivityPage(),
    GROUP: () => const GroupPage(),
  };

  // 当前选中的页面
  Widget getCurrentPage() {
    return pageMap[currentPage.value]!();
  }

  void setCurrentPage(String key) {
    currentPage.value = key;
  }
}
