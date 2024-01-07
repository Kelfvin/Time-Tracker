import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/controller/record_controller.dart';
import 'package:time_tracker/common/controller/user_controller.dart';
import 'package:time_tracker/page/time_line/timegrid/timgrid_controller.dart';
import 'package:time_tracker/common/model/event_record.dart';

class Timegrid extends StatelessWidget {
  final TimegridController controller = Get.put(TimegridController());

  final UserController userController = Get.find();

  Timegrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      controller.calculateEachWidthAndHeight(constraints);

      return Stack(
        children: [
          BackgroundGrid(controller: controller),
          RecordLayer(controller: controller),
          SelectedGrid(controller: controller),
          TimeCursor(controller: controller),
          GuestureDetector(controller: controller),
        ],
      );
    });
  }
}

/// 显示事件的一个小方块，1个1分钟
class Block extends StatelessWidget {
  final Color color;
  final int flex;
  final String? text;

  const Block({
    super.key,
    required this.color,
    required this.flex,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        padding: const EdgeInsets.all(1),
        child: Text(" $text",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class RecordLayer extends StatelessWidget {
  final TimegridController controller;
  final UserController userController = Get.find();

  final RecordController recordController = Get.find();

  RecordLayer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: getRows(),
        ));
  }

  /// 根据Records算出小方块列表
  List<Widget> getRows() {
    List<Widget> rows = [];

    // 将获取到的records按照开始时间排序
    controller.records.sort((a, b) => a.startTime.compareTo(b.startTime));

    // 保存上一次的结束时间,是当前行的开始时间
    // 从0点开始到24点，依次填充每一行

    for (int i = 0; i < 24; i++) {
      // 时间是当天的
      DateTime rowDateTime = DateTime(
          controller.currentTime.value.year,
          controller.currentTime.value.month,
          controller.currentTime.value.day,
          i,
          0,
          0);

      DateTime rowEndDateTime = rowDateTime.add(const Duration(hours: 1));

      DateTime lastEndTime = rowDateTime;

      Duration sumDuration = const Duration(minutes: 0);

      String text = "";

      // 一行的小方块
      List<Widget> blocks = [];
      // 遍历
      for (EventRecord record in recordController.records) {
        // 排除还在进行的record
        // TODO 以后修改逻辑，显示正在进行的recortd
        if (record.endTime == null) {
          continue;
        }

        // 排除法，如果record的开始时间在这一行的时间之后，那么这一行就不会有这个record
        // 如果结束时间在这一行的时间之前，那么这一行就不会有这个record
        if (record.startTime.isAfter(rowEndDateTime) ||
            record.endTime!.isBefore(rowDateTime)) {
          continue;
        }

        // 计算空白的时间
        Duration blankDuration = record.startTime.difference(lastEndTime);
        // 如果空白时间大于0，那么就添加一个空白的小方块
        if (blankDuration.inMinutes > 0) {
          sumDuration += blankDuration;
          blocks.add(
              Block(color: Colors.transparent, flex: blankDuration.inMinutes));
        }

        // 计算record在这一行的时间

        // 如果record在这一行的时间之前，那么就从0开始
        DateTime recordStart;

        if (record.startTime.isBefore(lastEndTime)) {
          recordStart = lastEndTime;
        } else {
          text = record.event.name;
          recordStart = record.startTime;
        }

        // 如果record超过了这一行的时间，那么就截断
        DateTime? recordEnd = record.endTime!.isBefore(rowEndDateTime)
            ? record.endTime
            : rowEndDateTime;

        Duration recordDuration = recordEnd!.difference(recordStart);

        sumDuration += recordDuration;

        // 添加record的小方块
        blocks.add(Block(
            color: record.event.color,
            flex: recordDuration.inMinutes,
            text: text));

        // 更新lastEndTime
        lastEndTime = record.endTime!;
      }

      // 添加最后的空白方块，60分钟减去所有的时间
      int blankFlex = 60 - sumDuration.inMinutes;
      if (blankFlex > 0) {
        blocks.add(Block(
          color: Colors.transparent,
          flex: blankFlex,
        ));
      }

      rows.add(Expanded(
          child: Row(
        children: blocks,
      )));
    }

    return rows;
  }
}

class TimeCursor extends StatelessWidget {
  const TimeCursor({
    super.key,
    required this.controller,
  });

  final TimegridController controller;

  @override
  Widget build(BuildContext context) {
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
}

class BackgroundGrid extends StatelessWidget {
  const BackgroundGrid({
    super.key,
    required this.controller,
  });

  final TimegridController controller;

  @override
  Widget build(BuildContext context) {
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
}

class GuestureDetector extends StatelessWidget {
  const GuestureDetector({
    super.key,
    required this.controller,
  });

  final TimegridController controller;

  @override
  Widget build(BuildContext context) {
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

class SelectedGrid extends StatelessWidget {
  const SelectedGrid({
    super.key,
    required this.controller,
  });

  final TimegridController controller;

  @override
  Widget build(BuildContext context) {
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
                        border: Border.all(
                            color: controller.cellSelected[i][j]
                                ? Colors.white
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(5),
                        color: controller.cellSelected[i][j]
                            ? const Color.fromARGB(70, 0, 0, 0)
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
}
