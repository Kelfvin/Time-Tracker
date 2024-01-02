import 'package:flutter/material.dart';
import 'package:time_tracker/page/statistic/widget/line_chart.dart';
import 'package:time_tracker/page/statistic/widget/list_chart.dart';
import 'package:time_tracker/page/statistic/widget/pie_chart.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      Wrap(
        children: [
          Card(
            child: ListTile(
              title: Text("每周时间统计", style: TextStyle(fontSize: 15)),
              subtitle: LineChart(),
            ),
          ),
          Card(child: PieChart()),
          Card(
            child: ListChart(),
          )
        ],
      ),
    ]);
  }
}
