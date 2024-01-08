import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/controller/category_controller.dart';
import 'package:time_tracker/common/dao/category_dao.dart';
import 'package:time_tracker/common/dao/event_dao.dart';

import 'package:time_tracker/common/model/event_category.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/common/controller/user_controller.dart';

/// 定义统一的样式
class TitleButton extends StatelessWidget {
  final String? text;
  final Color? color;

  /// 按下回调
  final VoidCallback? onTap;

  const TitleButton(
      {super.key, required this.text, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
  final VoidCallback? onTap;
  final CategoryController categoryController = Get.find();

  CategoryTitleButton({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        // 默认展开
        initiallyExpanded: true,
        title: TitleButton(
            text: category.name, color: category.color, onTap: onTap),
        // 不要描边
        shape: const Border(),
        children: [
          for (Event event in category.events!)
            EventTitleButton(
              event: event,
              onTap: () {
                // 确认删除的弹窗
                showEventDeleteDialog(event);
              },
            )
        ]);
  }

  void showEventDeleteDialog(Event event) {
    Get.defaultDialog(
        title: "删除事件",
        titleStyle: const TextStyle(fontSize: 15),
        content: SizedBox(
            height: 100,
            width: 300,
            child: Column(
              children: [
                const Text("删除事件后不可恢复，确认删除吗？"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("取消")),
                    TextButton(
                        onPressed: () async {
                          Get.back();
                          var result = await EventDao.deleteEvent(event.id!);
                          if (result) categoryController.featchData();
                        },
                        child: const Text("确认")),
                  ],
                )
              ],
            )));
  }
}

class EventTitleButton extends StatelessWidget {
  final Event event;
  final VoidCallback? onTap;

  const EventTitleButton({super.key, required this.event, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
      child: TitleButton(text: event.name, color: event.color, onTap: onTap),
    );
  }
}

class CategoryEventList extends StatelessWidget {
  final CategoryController categoryController = Get.find();

  CategoryEventList({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取数据

    return Obx(() => _buildVIew());
  }

  ListView _buildVIew() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        for (EventCategory category in categoryController.categories)
          CategoryTitleButton(
            category: category,
            onTap: () {
              // 确认删除的弹窗
              showCategoryDeleteDialog(category);
            },
          )
      ],
    );
  }

  void showCategoryDeleteDialog(EventCategory category) {
    Get.defaultDialog(
        title: "删除分类",
        titleStyle: const TextStyle(fontSize: 15),
        content: SizedBox(
            height: 100,
            width: 300,
            child: Column(
              children: [
                const Text("删除分类后，该分类下的事件也会被删除，确认删除吗？"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("取消")),
                    TextButton(
                        onPressed: () async {
                          Get.back();
                          var result =
                              await CategoryDao.deleteCategory(category.id!);
                          if (result) categoryController.featchData();
                        },
                        child: const Text("确认")),
                  ],
                )
              ],
            )));
  }
}
