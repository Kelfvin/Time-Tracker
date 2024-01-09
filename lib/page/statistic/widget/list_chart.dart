import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:time_tracker/common/controller/category_controller.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/common/utils/utils.dart';

class Item extends StatelessWidget {
  final String title;
  final double progress;
  final String time;
  final Color color;

  const Item(
      {super.key,
      required this.title,
      required this.progress,
      required this.time,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // 去掉边缘阴影和边缘的线
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(child: Text(title[0])),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title ${(progress * 100).toStringAsFixed(2)}%",
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            color: color,
            value: progress,
          )
        ],
      ),
      trailing: Text(time, style: const TextStyle(fontSize: 12)),
    );
  }
}

class ListChart extends StatelessWidget {
  final CategoryController categoryController = Get.find();

  ListChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildView());
  }

  Column _buildView() {
    List<Event> events = [];

    for (var category in categoryController.categories) {
      for (var event in category.events!) {
        if (event.duration.inSeconds > 0) {
          events.add(event);
        }
      }
    }

    return Column(
      children: [
        for (Event event in events)
          Item(
            title: event.name,
            progress: event.duration.inSeconds /
                categoryController.totalDuration.value.inSeconds,
            time: Utils.formatDurationTime(event.duration),
            color: event.color,
          )
      ],
    );
  }
}
