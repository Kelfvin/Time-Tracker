import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/common/controller/record_controller.dart';
import 'package:time_tracker/common/model/event_record.dart';
import 'package:time_tracker/page/time_line/time_line_page_controller.dart';

class Item extends StatelessWidget {
  final String title;
  final String time;
  final Color color;

  const Item(
      {super.key,
      required this.title,
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
          Text(title, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 5),
        ],
      ),
      trailing: Text(time, style: const TextStyle(fontSize: 12)),
    );
  }
}

class RecordListPage extends StatelessWidget {
  final RecordController recordController = Get.find();
  final TimeLinePageController timeLineController = Get.find();

  RecordListPage({super.key}) {
    // 获取数据
    recordController.fetchRecordByDay(timeLineController.focusedDay.value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildView());
  }

  Widget _buildView() {
    return Column(
      children: [
        const SizedBox(height: 20),
        // 添加标题
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  // 格式化日期，使用库
                  DateFormat("yyyy年MM月dd日")
                      .format(timeLineController.focusedDay.value),
                  style: const TextStyle(fontSize: 20)),
              Text("共${recordController.records.length}条记录",
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            // 添加分割线
            children: _buildItemsList(recordController.records),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildItemsList(List<EventRecord> records) {
    List<Widget> items = [];
    Widget divider = const Divider(
      height: 1,
      indent: 20,
      endIndent: 20,
    );
    for (EventRecord record in records) {
      Widget widget = Item(
          title: record.event.name,
          time: "${record.getStartTime()}-${record.getEndTime()}",
          color: record.event.color);

      items.add(widget);
      // 添加分割线

      items.add(divider);
    }
    return items;
  }
}
