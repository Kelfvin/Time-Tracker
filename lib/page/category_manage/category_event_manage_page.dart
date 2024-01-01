import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:time_tracker/common/model/category.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/common/routes/app_pages.dart';
import 'package:time_tracker/page/category_manage/add_category.dart';
import 'package:time_tracker/page/timegrid/widget/category_event_line/category_button.dart';
import 'package:time_tracker/page/category_manage/widget/category_event_list.dart';

///

/// 以层级列表的形式展示分类和事件
class CategoryManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CategoryEventList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: "添加分类",
              titleStyle: TextStyle(fontSize: 15),
              content: SizedBox(
                  height: 600, width: 700, child: AddCategoryEventPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
