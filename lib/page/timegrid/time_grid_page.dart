import 'package:flutter/material.dart';
import "package:table_calendar/table_calendar.dart";
import 'package:time_tracker/page/timegrid/widget/timegrid/timegrid.dart';

import 'widget/category_event_line/category_event_line.dart';
import '../../widget/time_line/time_line.dart';

class TimeGridPage extends StatelessWidget {
  const TimeGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(1999, 10, 16),
          lastDay: DateTime.utc(2999, 3, 14),
          focusedDay: DateTime.now(),
          // 显示一周
          calendarFormat: CalendarFormat.week,
          // 中文模式
          locale: "zh_CN",
          // 关闭模式切换
          availableCalendarFormats: const {CalendarFormat.week: ""},
        ),
        Expanded(
          child: Row(
            children: [
              SizedBox(width: 70, child: TimeLine()),
              Expanded(flex: 4, child: Timegrid()),
              SizedBox(width: 70, child: CategoryEventLine()),
            ],
          ),
        ),
      ],
    );
  }
}
