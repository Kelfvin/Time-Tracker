import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/controller/category_controller.dart';
import 'package:time_tracker/page/statistic/controller.dart';

class DateRangePicker extends StatelessWidget {
  final StatisticPageController statisticPageController = Get.find();
  final CategoryController categoryController = Get.find();
  DateRangePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildView());
  }

  Row _buildView() {
    return Row(
      children: [
        // 左边的日、周、年模式选择
        Expanded(
          child: Row(
            children: [
              _buildModeButton(DateRangeMode.day),
              _buildModeButton(DateRangeMode.week),
              _buildModeButton(DateRangeMode.month),
              _buildModeButton(DateRangeMode.year),
            ],
          ),
        ),
        // 右边的左右切换和显示时间范围的按钮
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: () {
                // 处理左切换逻辑
                statisticPageController.previousDateRange();
                // 获取当前时间范围内的数据
                DateTime? start =
                    statisticPageController.dateRange.value?.start;
                DateTime? end = statisticPageController.dateRange.value?.end;

                if (start != null && end != null) {
                  categoryController.featchDateOfDateRange(start, end);
                }
              },
            ),
            Text(statisticPageController.getFormattedDateRange()),
            IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: () {
                // 处理右切换逻辑
                statisticPageController.nextDateRange();
                // 获取当前时间范围内的数据
                DateTime? start =
                    statisticPageController.dateRange.value?.start;
                DateTime? end = statisticPageController.dateRange.value?.end;

                if (start != null && end != null) {
                  categoryController.featchDateOfDateRange(start, end);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModeButton(DateRangeMode mode) {
    return Row(
      children: [
        Radio<DateRangeMode>(
          value: mode,
          groupValue: statisticPageController.dateRangeMode.value,
          onChanged: (DateRangeMode? value) {
            statisticPageController.changeDateRangeMode(value!);
          },
        ),
        Text(mode.toString()),
      ],
    );
  }
}
