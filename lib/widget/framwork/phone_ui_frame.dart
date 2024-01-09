import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/widget/framwork/ui_frame_controller.dart';

class PhoneUIFrame extends StatelessWidget {
  final UIFrameController uiController = Get.find();
  PhoneUIFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildView());
  }

  Scaffold _buildView() {
    return Scaffold(
        appBar: AppBar(
          title: const Text("时光迹"),
        ),
        body: uiController.getCurrentPage(),
        bottomNavigationBar:
            ButtonBar(alignment: MainAxisAlignment.center, children: [
          for (var item in UIFrameController.iconMap.keys)
            IconButton(
              onPressed: () {
                uiController.currentPage.value = item;
              },
              icon: Icon(
                UIFrameController.iconMap[item],
                color: uiController.currentPage.value == item
                    ? Colors.blue
                    : Colors.grey,
              ),
            )
        ]));
  }
}
