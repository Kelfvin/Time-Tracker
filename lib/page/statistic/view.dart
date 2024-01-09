import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/controller/category_controller.dart';
import 'package:time_tracker/page/statistic/controller.dart';
import 'package:time_tracker/page/statistic/widget/date_range_picker.dart';
import 'package:time_tracker/page/statistic/widget/line_chart.dart';
import 'package:time_tracker/page/statistic/widget/list_chart.dart';
import 'package:time_tracker/page/statistic/widget/pie_chart.dart';

class StatisticPage extends StatelessWidget {
  final StatisticPageController statisticPageController =
      Get.put(StatisticPageController());

  final CategoryController categoryController = Get.find();

  StatisticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? start = statisticPageController.dateRange.value?.start;
    DateTime? end = statisticPageController.dateRange.value?.end;

    if (start != null && end != null) {
      categoryController.featchDateOfDateRange(start, end);
    }

    return Obx(() => _buildView());
  }

  Widget _buildView() {
    List<Widget> components = [];

    if (statisticPageController.dateRangeMode.value == DateRangeMode.day) {
      components = _buildDayComponents();
    } else {
      components = _buildMultiDayComponents();
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(children: [
        Card(child: DateRangePicker()),
        Wrap(children: components)
      ]),
    );
  }

  List<Widget> _buildDayComponents() {
    List<Widget> components = [];
    components.add(
      Card(child: PieChart()),
    );
    components.add(
      Card(
        child: ListChart(),
      ),
    );

    return components;
  }

  List<Widget> _buildMultiDayComponents() {
    List<Widget> components = [];
    components.add(
      Card(child: PieChart()),
    );
    components.add(
      Card(
        child: ListChart(),
      ),
    );

    components.add(
      Card(
        child: LineChart(),
      ),
    );

    return components;
  }
}
