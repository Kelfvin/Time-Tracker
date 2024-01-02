import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/page/activity/activity_controller.dart';
import 'package:time_tracker/common/model/category.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/common/utils/data.dart';
import 'package:time_tracker/page/activity/widget/activiting_widget.dart';
import 'package:time_tracker/page/activity/widget/event_button.dart';
import 'package:time_tracker/page/activity/widget/section.dart';

/// 活动页面，点击活动按钮从当前开始进行计时
class ActivityPage extends StatelessWidget {
  /// 记录当前正在进行的事件
  final ActivityConrtoller activityConrtoller =
      Get.put(ActivityConrtoller(), tag: "activityConrtoller");

  ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Category> catgories = DataUtils.generateTestCategories();

    return ListView(
      children: [
        const SizedBox(height: 40),
        ActivatingWidget(),
        const SizedBox(height: 20),
        ..._buildCategorySections(catgories),
      ],
    );
  }

  List<Widget> _buildCategorySections(List<Category> categories) {
    List<Widget> sections = [];

    for (Category category in categories) {
      sections.add(Section(
        title: category.name,
        buttons: _buildButtons(category.events ?? []),
      ));
    }
    return sections;
  }

  List<EventButton> _buildButtons(List<Event> events) {
    List<EventButton> buttons = [];

    for (Event event in events) {
      buttons.add(EventButton(
        event: event,
      ));
    }
    return buttons;
  }
}
