import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/page/statistic/controller.dart';
import 'package:time_tracker/page/statistic/widget/date_range_picker.dart';
import 'package:time_tracker/page/statistic/widget/line_chart.dart';
import 'package:time_tracker/page/statistic/widget/list_chart.dart';
import 'package:time_tracker/page/statistic/widget/pie_chart.dart';

class StatisticPage extends StatelessWidget {
  final StatisticPageController statisticPageController =
      Get.put(StatisticPageController());

  StatisticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildView());
  }

  Widget _buildView() {
    List<Widget> components = [];

    if (statisticPageController.dateRangeMode.value == DateRangeMode.day) {
      components = _buildDayComponents();
    } else {
      components = _buildMultiDayComponents();
    }

    return ListView(children: [DateRangePicker(), Wrap(children: components)]);
  }

  List<Widget> _buildDayComponents() {
    List<Widget> components = [];
    components.add(
      const Card(child: PieChart()),
    );
    components.add(
      const Card(
        child: ListChart(),
      ),
    );

    return components;
  }

  List<Widget> _buildMultiDayComponents() {
    List<Widget> components = [];
    components.add(
      const Card(child: PieChart()),
    );
    components.add(
      const Card(
        child: ListChart(),
      ),
    );

    components.add(
      const Card(
        child: LineChart(),
      ),
    );

    return components;
  }
}
