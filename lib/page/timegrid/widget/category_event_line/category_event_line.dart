import 'package:flutter/material.dart';
import 'package:time_tracker/common/model/category.dart';
import 'package:time_tracker/common/model/event.dart';

import 'category_button.dart';

/// 分类和动作的一个纵向滑动的列表
class CategoryEventLine extends StatelessWidget {
  /// 生成测试数据

  final categoryNames = ["学习", "工作", "娱乐", "运动", "睡觉", "吃饭"];
  final eventNames = ["学习", "工作", "娱乐", "运动", "睡觉", "吃饭"];

  /// 彩虹颜色
  final List<Color> colorList = [
    const Color(0xff2eaefd),
    const Color(0xff41e28c),
    const Color(0xfff66c89),
    const Color(0xfffdc33f),
    const Color(0xffa25ddc),
    const Color(0xff2eaefd),
  ];

  CategoryEventLine({super.key});

  List<Category> generateTestData() {
    List<Category> categories = [];
    for (int i = 0; i < 6; i++) {
      Category category = Category(name: categoryNames[i]);

      for (int j = 0; j < 5; j++) {
        Event event =
            Event(name: eventNames[j], color: colorList[j], categoryId: i);
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
        for (Category category in categories) CategoryButton(category: category)
      ],
    );
  }
}
