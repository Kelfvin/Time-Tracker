import 'package:flutter/material.dart';
import 'package:time_tracker/common/model/category.dart';
import 'package:time_tracker/common/model/event.dart';

import 'category_button.dart';

/// 分类和动作的一个纵向滑动的列表
class CategoryEventLine extends StatelessWidget {
  /// 生成测试数据

  var CATEGORY = ["学习", "工作", "娱乐", "运动", "睡觉", "吃饭"];
  var EVENT = ["学习", "工作", "娱乐", "运动", "睡觉", "吃饭"];

  /// 彩虹颜色
  var COLOR = [
    0xFFE57373,
    0xFFF06292,
    0xFFBA68C8,
  ];

  List<Category> generateTestData() {
    List<Category> categories = [];
    for (int i = 0; i < 6; i++) {
      Category category = Category(name: CATEGORY[i]);

      for (int j = 0; j < 3; j++) {
        Event event = Event(name: EVENT[j], color: COLOR[j]);
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
