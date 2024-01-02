import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatelessWidget {
  const LineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      legend: const Legend(isVisible: true, position: LegendPosition.bottom),
      trackballBehavior: TrackballBehavior(
        // 使用虚线
        lineType: TrackballLineType.vertical,
        lineDashArray: const <double>[5, 5],
        // 单击显示
        activationMode: ActivationMode.singleTap,
        shouldAlwaysShow: true,
        enable: true,
        // 显示成一个框
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      ),
      primaryXAxis: DateTimeAxis(
          //按照周显示，一、二、三、四、五、六、日
          intervalType: DateTimeIntervalType.days,
          interval: 1,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          //显示时间

          ),
      series: <ChartSeries>[
        SplineSeries<SalesData, DateTime>(
            name: "学习",
            dataSource: _getRandomData(),
            xValueMapper: (SalesData sales, _) => sales.date,
            yValueMapper: (SalesData sales, _) => sales.sales),
        SplineSeries<SalesData, DateTime>(
            name: "工作",
            dataSource: _getRandomData(),
            xValueMapper: (SalesData sales, _) => sales.date,
            yValueMapper: (SalesData sales, _) => sales.sales),
        SplineSeries<SalesData, DateTime>(
            name: "娱乐",
            dataSource: _getRandomData(),
            xValueMapper: (SalesData sales, _) => sales.date,
            yValueMapper: (SalesData sales, _) => sales.sales),
      ],
    );
  }

  // 产生随机数据
  List<SalesData> _getRandomData() {
    final List<SalesData> data = <SalesData>[];
    for (int i = 0; i < 7; i++) {
      data.add(SalesData(
          DateTime(2023, 12, i + 1), Random().nextInt(20).toDouble()));
    }
    return data;
  }
}

class SalesData {
  SalesData(this.date, this.sales);
  final DateTime date;
  final double sales;
}
