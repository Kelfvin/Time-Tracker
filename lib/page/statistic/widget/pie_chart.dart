import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:time_tracker/common/controller/category_controller.dart';
import 'package:time_tracker/common/model/event_category.dart';
import 'package:time_tracker/common/utils/utils.dart';

class PieChart extends StatelessWidget {
  final CategoryController categoryController = Get.find();

  final exploadIndex = Rx<int?>(null);
  PieChart({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO 创建数据

    return Obx(() => _buildView());
  }

  Widget _buildView() {
    return SfCircularChart(
      legend: const Legend(isVisible: false),
      annotations: [
        CircularChartAnnotation(
            // 关闭侧边图标
            widget: _buildCircleInfo(),
            radius: '0%')
      ],
      series: <CircularSeries>[
        DoughnutSeries<EventCategory, String>(
          animationDuration: 0,
          explode: true,
          explodeIndex: exploadIndex.value,
          dataSource: categoryController.categories.value,
          xValueMapper: (EventCategory data, _) => data.name,
          yValueMapper: (EventCategory data, _) =>
              data.duration?.inMicroseconds == 0
                  ? null
                  : data.duration?.inMicroseconds,
          dataLabelMapper: (EventCategory data, _) => data.name,
          pointColorMapper: (EventCategory data, _) => data.color,
          // 触摸时的偏移量
          onPointTap: (ChartPointDetails details) {
            if (details.pointIndex == exploadIndex.value) {
              exploadIndex.value = null;
            } else {
              exploadIndex.value = details.pointIndex;
            }
            print(exploadIndex.value);
          },

          innerRadius: '70%',
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelIntersectAction: LabelIntersectAction.shift,
            labelPosition: ChartDataLabelPosition.outside,
          ),
        )
      ],
    );
  }

  Column _buildCircleInfo() {
    String title = "";
    String durationInfo = "";

    if (exploadIndex.value == null) {
      title = "总时长";
      durationInfo =
          Utils.formatDurationTime(categoryController.totalDuration.value);
    } else {
      EventCategory category =
          categoryController.categories[exploadIndex.value!];
      title = category.name;
      durationInfo =
          Utils.formatDurationTime(category.duration ?? Duration.zero);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
        Text(
          durationInfo,
          style: const TextStyle(fontSize: 10),
        )
      ],
    );
  }
}
