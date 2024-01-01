import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import "package:table_calendar/table_calendar.dart";
import 'package:time_tracker/page/timegrid/widget/timegrid/timegrid.dart';
import 'package:time_tracker/page/timegrid/widget/timegrid/timgrid_controller.dart';

import 'widget/category_event_line/category_event_line.dart';
import 'widget/time_line/time_line.dart';

class TimeGridPage extends StatelessWidget {
  final TimegridController controller =
      Get.put(TimegridController(), tag: "timegridController", permanent: true);

  TimeGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildPage());
  }

  Widget _buildPage() {
    return Column(
      children: [
        buildCalendar(),
        Expanded(
          child: Row(
            children: [
              TimeLine(),
              Expanded(flex: 4, child: Timegrid()),
              SizedBox(width: 70, child: CategoryEventLine()),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCalendar() {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 20),
            Text(
              "${controller.focusedDay.value.year}年${controller.focusedDay.value.month}月${controller.focusedDay.value.day}日",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Expanded(child: Container()),
            IconButton(
              onPressed: () {
                controller.changeFocusDay(DateTime.now());
              },
              icon: const Icon(Icons.today),
            ),
            IconButton(
              onPressed: () {
                controller.changeFocusDay(controller.focusedDay.value
                    .subtract(const Duration(days: 1)));
              },
              icon: const Icon(Icons.arrow_left),
            ),
            IconButton(
              onPressed: () {
                controller.changeFocusDay(
                    controller.focusedDay.value.add(const Duration(days: 1)));
              },
              icon: const Icon(Icons.arrow_right),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TableCalendar(
          firstDay: DateTime.utc(1999, 10, 16),
          lastDay: DateTime.utc(2999, 3, 14),
          focusedDay: controller.focusedDay.value,
          // 显示一周
          calendarFormat: CalendarFormat.week,
          // 中文模式
          locale: "zh_CN",
          // 关闭模式切换
          availableCalendarFormats: const {CalendarFormat.week: ""},
          // 选中日期
          selectedDayPredicate: (day) {
            return isSameDay(controller.focusedDay.value, day);
          },

          // 关闭头部
          headerVisible: false,

          // 第一天显示星期1
          startingDayOfWeek: StartingDayOfWeek.monday,

          // 滑动切换日期
          onPageChanged: (focusedDay) {
            controller.changeFocusDay(focusedDay);
          },

          // 选中日期回调
          onDaySelected: (selectedDay, focusedDay) {
            controller.changeFocusDay(selectedDay);
          },
        ),
      ],
    );
  }
}
