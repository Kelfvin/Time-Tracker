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
        const SizedBox(
          width: 10,
        ),
        // 左边的日、周、年模式选择

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          width: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: ModeButton(mode: DateRangeMode.day)),
              Expanded(child: ModeButton(mode: DateRangeMode.week)),
              Expanded(child: ModeButton(mode: DateRangeMode.month)),
              Expanded(child: ModeButton(mode: DateRangeMode.year)),
            ],
          ),
        ),
        Expanded(child: Container()),
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
            // 获取当前时间范围内的数据
            DateTime? start = statisticPageController.dateRange.value?.start;
            DateTime? end = statisticPageController.dateRange.value?.end;

            if (start != null && end != null) {
              categoryController.featchDateOfDateRange(start, end);
            }
          },
        ),
        Text(mode.toString()),
      ],
    );
  }
}

class ModeButton extends StatelessWidget {
  final DateRangeMode mode;
  final StatisticPageController statisticPageController = Get.find();
  final CategoryController categoryController = Get.find();
  ModeButton({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: statisticPageController.dateRangeMode.value == mode
            ? Colors.blue
            : Colors.white,
      ),
      child: GestureDetector(
        child: Center(child: Text(mode.toString())),
        onTap: () {
          statisticPageController.changeDateRangeMode(mode);
          // 获取当前时间范围内的数据
          DateTime? start = statisticPageController.dateRange.value?.start;
          DateTime? end = statisticPageController.dateRange.value?.end;

          if (start != null && end != null) {
            categoryController.featchDateOfDateRange(start, end);
          }
        },
      ),
    );
  }
}
