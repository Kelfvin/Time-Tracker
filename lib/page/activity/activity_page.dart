import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/controller/category_controller.dart';
import 'package:time_tracker/common/controller/record_controller.dart';
import 'package:time_tracker/page/activity/activity_controller.dart';
import 'package:time_tracker/common/model/event_category.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/page/activity/widget/activiting_widget.dart';
import 'package:time_tracker/page/activity/widget/event_button.dart';
import 'package:time_tracker/page/activity/widget/section.dart';

/// 活动页面，点击活动按钮从当前开始进行计时
class ActivityPage extends StatelessWidget {
  /// 记录当前正在进行的事件
  final ActivityConrtoller activityConrtoller = Get.put(
    ActivityConrtoller(),
  );

  final CategoryController categoryController = Get.find();

  final RecordController recordController = Get.find();

  ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List<EventCategory> catgories = DataUtils.generateTestCategories();
    categoryController.featchDateOfDate(DateTime.now());
    recordController.fetchCurrentRecord();

    return Obx(() => Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              ActivatingWidget(),
              const SizedBox(height: 20),
              ..._buildCategorySections(categoryController.categories),
            ],
          ),
        ));
  }

  List<Widget> _buildCategorySections(List<EventCategory> categories) {
    List<Widget> sections = [];

    for (EventCategory category in categories) {
      sections.add(Section(
        title: category.name,
        buttons: _buildButtons(category.events ?? []),
      ));

      sections.add(const SizedBox(height: 20));
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
