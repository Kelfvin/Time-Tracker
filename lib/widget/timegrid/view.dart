import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/widget/timegrid/timgrid_controller.dart';

class Timegrid extends StatelessWidget {
  TimegridController controller =
      Get.put(TimegridController(), tag: "timegridController");

  Timegrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      controller.calculateEachWidthAndHeight(constraints);

      return Stack(
        children: [
          generateBackgroundGrid(),
          generateSelectedGrid(),
          generateTimeCursor(),
          generateGuestureDetector(),
        ],
      );
    });
  }

  /// 生成时间指针
  Widget generateTimeCursor() {
    Widget timeCursor() {
      /// 计算当前时间指针的位置
      double top =
          controller.eachHeight.value * controller.currentTime.value.hour;

      double left = controller.eachWidth.value *
          controller.currentTime.value.minute /
          controller.splitSpan.value;

      return Positioned(
        top: top,
        left: left,
        child: Container(
          height: controller.eachHeight.value,
          width: 3,
          color: Colors.red,
        ),
      );
    }

    return Obx(() => timeCursor());
  }

  /// 显示选中的格子的层
  Widget generateSelectedGrid() {
    Widget selectedGrid() {
      return Column(children: [
        for (int i = 0; i < controller.rowNum.value; i++)
          Expanded(
            child: Row(
              children: [
                for (int j = 0; j < controller.colNum.value; j++)
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                        color: controller.cellSelected[i][j]
                            ? const Color.fromARGB(255, 19, 148, 223)
                            : Colors.transparent,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ]);
    }

    return Obx(() => selectedGrid());
  }

  /// 生成背景网格
  Widget generateBackgroundGrid() {
    return Positioned(
      child: Column(
        children: [
          for (int i = 0; i < controller.rowNum.value; i++)
            Expanded(
              child: Row(
                children: [
                  for (int j = 0; j < controller.colNum.value; j++)
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromRGBO(196, 223, 255, 1),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// 生成触摸层
  Widget generateGuestureDetector() {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onPanDown: controller.onTouchLayerDown,
        onPanUpdate: controller.onTouchLayerUpdate,
        child: Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          color: Colors.transparent,
        ),
      );
    });
  }
}
