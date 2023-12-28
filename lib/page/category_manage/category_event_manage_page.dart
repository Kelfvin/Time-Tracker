import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:time_tracker/common/model/category.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/common/routes/app_pages.dart';
import 'package:time_tracker/widget/category_event_line/category_button.dart';
import 'package:time_tracker/page/category_manage/widget/category_event_list.dart';

///

/// 以层级列表的形式展示分类和事件
class CategoryManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分类管理"),
      ),
      body: CategoryEventList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppPages.AddCategoryEvent);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
