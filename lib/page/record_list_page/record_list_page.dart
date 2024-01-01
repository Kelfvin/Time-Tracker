import 'package:flutter/material.dart';
import 'package:time_tracker/common/utils/data.dart';
import 'package:time_tracker/common/model/record.dart';

class Item extends StatelessWidget {
  String title = "";
  String time = "";
  Color color = Colors.red;

  Item(
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
  const RecordListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取数据
    List<Record> records = DataUtils.generateTestRecords();

    return Column(
      children: [
        SizedBox(height: 20),
        // 添加标题
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("记录: xx月xx日", style: TextStyle(fontSize: 20)),
              Text("共${records.length}条记录",
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            // 添加分割线
            children: _buildItemsList(records),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildItemsList(List<Record> records) {
    List<Widget> items = [];
    Widget divider = const Divider(
      height: 1,
      indent: 20,
      endIndent: 20,
    );
    for (Record record in records) {
      Widget widget = Item(
          title: record.event.name,
          time: record.getStartTime() + "-" + record.getEndTime(),
          color: record.event.color);

      items.add(widget);
      // 添加分割线

      items.add(divider);
    }
    return items;
  }
}
