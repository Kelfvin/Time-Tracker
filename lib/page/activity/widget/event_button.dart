import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/page/activity/activity_controller.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/common/utils/utils.dart';

class EventButton extends StatelessWidget {
  final Event event;

  final ActivityConrtoller activityConrtoller =
      Get.find(tag: "activityConrtoller");

  EventButton({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Material(
        color: event.color,
        child: Ink(
          height: 60,
          width: 100,
          child: InkWell(
            onTap: () {
              activityConrtoller.startNewActivity(event);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(event.name, style: const TextStyle(fontSize: 15)),
                // 时间间隔格式化输出，比如 1小时30分钟

                Text(
                  Utils.formatDurationTime(event.duration),
                  style: const TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
