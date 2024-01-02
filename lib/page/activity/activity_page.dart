import 'dart:math';

import 'package:flutter/material.dart';
import 'package:time_tracker/page/activity/widget/activiting_widget.dart';
import 'package:time_tracker/page/activity/widget/event_button.dart';
import 'package:time_tracker/page/activity/widget/section.dart';

/// 活动页面，点击活动按钮从当前开始进行计时
class ActivityPage extends StatelessWidget {
  /// 生成测试数据
  List<EventButton> generateTestData() {
    ///高亮颜色
    const List<Color> COLORS = [
      Color(0xff2eaefd),
      Color(0xff41e28c),
      Color(0xfff66c89),
      Color(0xfffdc33f),
      Color(0xffa25ddc),
      Color(0xff2eaefd),
    ];

    List<EventButton> buttons = [];
    for (int i = 0; i < 6; i++) {
      EventButton button = EventButton(
          title: "学习",
          color: COLORS[i],
          duration: Duration(seconds: Random().nextInt(10000)));
      buttons.add(button);
    }
    return buttons;
  }

  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        const Text("活动", style: TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        const ActivatingWidget(),
        const SizedBox(height: 20),
        Section(
          title: "活动分类1",
          buttons: generateTestData(),
        ),
        const SizedBox(height: 20),
        Section(
          title: "活动分类2",
          buttons: generateTestData(),
        ),
        const SizedBox(height: 20),
        Section(
          title: "活动分类3",
          buttons: generateTestData(),
        ),
      ],
    );
  }
}
