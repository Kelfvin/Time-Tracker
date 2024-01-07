import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:time_tracker/common/model/event_category.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/common/controller/user_controller.dart';

/// 定义统一的样式
class TitleButton extends StatelessWidget {
  final String? text;
  final Color? color;

  /// 按下回调
  final VoidCallback? onPressed;

  const TitleButton(
      {super.key, required this.text, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              width: 15,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(text ?? ""),
          ],
        ),
      ),
    );
  }
}

/// 分类列表
class CategoryTitleButton extends StatelessWidget {
  final EventCategory category;

  const CategoryTitleButton({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        // 默认展开
        initiallyExpanded: true,
        title:
            TitleButton(text: category.name, color: Color(category.color ?? 0)),
        // 不要描边
        shape: const Border(),
        children: [
          for (Event event in category.events!) EventTitleButton(event: event)
        ]);
  }
}

class EventTitleButton extends StatelessWidget {
  final Event event;

  const EventTitleButton({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
      child: TitleButton(text: event.name, color: event.color),
    );
  }
}

class CategoryEventList extends StatelessWidget {
  final UserController userController = Get.find();

  CategoryEventList({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取数据

    return Obx(() => ListView(
          scrollDirection: Axis.vertical,
          children: [
            for (EventCategory category in userController.categories)
              CategoryTitleButton(category: category)
          ],
        ));
  }
}
