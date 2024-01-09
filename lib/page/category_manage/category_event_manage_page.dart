import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/controller/category_controller.dart';
import 'package:time_tracker/page/category_manage/add_category.dart';
import 'package:time_tracker/page/category_manage/add_event.dart';
import 'package:time_tracker/page/category_manage/widget/category_event_list.dart';

///

/// 以层级列表的形式展示分类和事件
class CategoryManagePage extends StatelessWidget {
  final CategoryController categoryController = Get.find();

  CategoryManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    categoryController.featchData();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CategoryEventList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 手机端就直接跳转
          if (GetPlatform.isMobile) {
            Get.to(() => Scaffold(
                  appBar: AppBar(),
                  backgroundColor: Colors.white,
                  body: _buildView(),
                ));
            return;
          }

          Get.defaultDialog(
              title: "",
              titleStyle: const TextStyle(fontSize: 15),
              content: SizedBox(height: 600, width: 900, child: _buildView()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildView() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const TabBar(
          tabs: [
            Text("添加事件"),
            Text("增加分类"),
          ],
          // 居中

          // 多个标签时滚动加载
          isScrollable: true,
          // 标签指示器的颜色
          indicatorColor: Colors.red,
          // 标签的颜色
          labelColor: Colors.red,
          // 未选中标签的颜色
          unselectedLabelColor: Colors.black,
          // 指示器的大小
          indicatorSize: TabBarIndicatorSize.label,
          // 指示器的权重，即线条高度
          indicatorWeight: 4.0,
        ),
        body: TabBarView(children: [
          AddEventWidget(),
          AddCategoryEventPage(),
        ]),
      ),
    );
  }
}
