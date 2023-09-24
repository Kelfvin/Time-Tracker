import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/home_page.dart';
import 'package:time_tracker/page/database/view.dart';

import 'index.dart';

class HomePage extends GetView<HomeController> {
  final HomeController homeController = Get.put(HomeController());
  HomePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return Center(
      child: Text("${homeController.pageIndex.value}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      id: "home",
      builder: (_) {
        return Scaffold(
          body: Obx(() => IndexedStack(
                index: homeController.pageIndex.value,
                children: [
                  TimeGridPage(),
                  DatabasePage(),
                  Text("home3"),
                ],
              )),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "记录"),
              BottomNavigationBarItem(icon: Icon(Icons.timelapse), label: "统计"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "设置"),
            ],
            onTap: homeController.changePageIdx,
          ),
        );
      },
    );
  }
}
