import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/page/category_manage/add_category.dart';
import 'package:time_tracker/page/category_manage/widget/category_event_list.dart';

///

/// 以层级列表的形式展示分类和事件
class CategoryManagePage extends StatelessWidget {
  const CategoryManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: const CategoryEventList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: "添加分类",
              titleStyle: const TextStyle(fontSize: 15),
              content: const SizedBox(
                  height: 600, width: 700, child: AddCategoryEventPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
