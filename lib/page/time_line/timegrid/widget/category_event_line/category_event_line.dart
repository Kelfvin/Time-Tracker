import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:time_tracker/common/model/event_category.dart';

import 'package:time_tracker/common/controller/user_controller.dart';

import 'category_button.dart';

/// 分类和动作的一个纵向滑动的列表
class CategoryEventLine extends StatelessWidget {
  /// 生成测试数据

  final UserController userController = Get.find();

  CategoryEventLine({super.key}) {
    userController.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    // 获取数据
    return Obx(() => ListView(
          scrollDirection: Axis.vertical,
          children: [
            for (EventCategory category in userController.categories)
              CategoryButton(category: category)
          ],
        ));
  }
}
