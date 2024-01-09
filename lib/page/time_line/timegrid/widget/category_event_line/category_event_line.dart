import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/controller/category_controller.dart';

import 'package:time_tracker/common/model/event_category.dart';

import 'category_button.dart';

/// 分类和动作的一个纵向滑动的列表
class CategoryEventLine extends StatelessWidget {
  /// 生成测试数据

  final CategoryController categoryController = Get.find();

  CategoryEventLine({super.key}) {}

  @override
  Widget build(BuildContext context) {
    // 获取数据
    return Obx(() => ListView(
          scrollDirection: Axis.vertical,
          children: [
            for (EventCategory category in categoryController.categories)
              CategoryButton(category: category)
          ],
        ));
  }
}
