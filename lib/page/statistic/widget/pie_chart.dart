import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatelessWidget {
  const PieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(isVisible: false),
      annotations: [
        CircularChartAnnotation(
            // 关闭侧边图标
            widget: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "总时长",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "12小时11分钟",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            radius: '0%')
      ],
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
          dataSource: <ChartData>[
            ChartData("吃饭", 10),
            ChartData("睡觉", 20),
            ChartData("写代码", 30),
            ChartData("洗漱", 40),
            ChartData("上课", 50),
            ChartData("社交", 60),
          ],
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          dataLabelMapper: (ChartData data, _) => data.x,
          innerRadius: '70%',
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelIntersectAction: LabelIntersectAction.shift,
              labelPosition: ChartDataLabelPosition.outside,
              connectorLineSettings: ConnectorLineSettings(
                  type: ConnectorType.curve, length: '25%')),
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class SalesData {
  SalesData(this.date, this.sales);
  final DateTime date;
  final double sales;
}
