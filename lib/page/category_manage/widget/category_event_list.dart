import 'package:flutter/material.dart';
import 'package:time_tracker/common/model/category.dart';
import 'package:time_tracker/common/model/event.dart';

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
  final Category category;

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
  const CategoryEventList({super.key});

  /// 生成测试数据
  List<Category> generateTestData() {
    final CATEGORY = ["学习", "工作", "娱乐", "运动", "睡觉", "吃饭"];
    final EVENT = ["学习", "工作", "娱乐", "运动", "睡觉", "吃饭"];

    /// 彩虹颜色
    final COLOR = [
      0xFFE57373,
      0xFFF06292,
      0xFFBA68C8,
      0xFF9575CD,
      0xFF7986CB,
      0xFF64B5F6,
    ];

    List<Category> categories = [];
    for (int i = 0; i < 6; i++) {
      Category category = Category(name: CATEGORY[i], color: COLOR[i]);

      for (int j = 0; j < 3; j++) {
        Event event =
            Event(name: EVENT[j], color: Color(COLOR[i]), categoryId: i);
        category.events!.add(event);
      }
      categories.add(category);
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    // 获取数据
    List<Category> categories = generateTestData();

    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        for (Category category in categories)
          CategoryTitleButton(category: category)
      ],
    );
  }
}
