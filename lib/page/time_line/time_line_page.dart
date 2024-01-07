import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:table_calendar/table_calendar.dart";
import 'package:time_tracker/common/controller/record_controller.dart';
import 'package:time_tracker/page/record_list/record_list_page.dart';
import 'package:time_tracker/page/time_line/time_line_page_controller.dart';
import 'package:time_tracker/page/time_line/timegrid/view.dart';

/// 时间线页面，用于呈现这种时间记录，但不涉及统计
class TimeLinePage extends StatelessWidget {
  final RecordController recordController = Get.find();

  final TimeLinePageController pageController =
      Get.put(TimeLinePageController());

  TimeLinePage({super.key}) {
    recordController.fetchRecordByDay(pageController.focusedDay.value);
  }

  @override
  Widget build(BuildContext context) {

    // return Placeholder();
    return Obx(() => _buildPage());
  }

  Widget _buildPage() {
    return Column(
      children: [_buildTitleBar(), buildCalendar(), buildMainView()],
    );
  }

  /// 构建中间主视图
  Widget buildMainView() {
    // if (controller.viewMode.value == ViewMode.timeLine) {
    //   return const Expanded(child: RecordListPage());
    // } else {
    //   return Expanded(child: TimeGridView());
    // }
    if (pageController.currentViewMode.value == ViewMode.timeLine) {
      return Expanded(child: RecordListPage());
    } else {
      return Expanded(child: TimeGridView());
    }
  }

  /// 构建一个选择项的行，用于选择是时间线还是时间表格
  Row buildSelectRow() {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              pageController.changeViewMode(ViewMode.timeLine);
            },
            child: const Text("时间线"),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              pageController.changeViewMode(ViewMode.timeGrid);
            },
            child: const Text("时间表格"),
          ),
        ),
      ],
    );
  }

  Widget buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(1999, 10, 16),
      lastDay: DateTime.utc(2999, 3, 14),
      focusedDay: pageController.focusedDay.value,
      // 显示一周
      calendarFormat: CalendarFormat.week,
      // 中文模式
      locale: "zh_CN",
      // 关闭模式切换
      availableCalendarFormats: const {CalendarFormat.week: ""},
      // 选中日期
      selectedDayPredicate: (day) {
        return isSameDay(pageController.focusedDay.value, day);
      },

      // 关闭头部
      headerVisible: false,

      // 第一天显示星期1
      startingDayOfWeek: StartingDayOfWeek.monday,

      // 滑动切换日期
      onPageChanged: (focusedDay) {
        pageController.changeDate(focusedDay);
      },

      // 选中日期回调
      onDaySelected: (selectedDay, focusedDay) {
        pageController.changeDate(selectedDay);
      },
    );
  }

  /// 构建标题栏
  Row _buildTitleBar() {
    return Row(
      children: [
        const SizedBox(width: 20),
        Text(
          "${pageController.focusedDay.value.year}年${pageController.focusedDay.value.month}月${pageController.focusedDay.value.day}日",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        IconButton(
          onPressed: () {
            pageController.changeDate(pageController.focusedDay.value
                .subtract(const Duration(days: 1)));
          },
          icon: const Icon(Icons.arrow_left),
        ),
        IconButton(
          onPressed: () {
            pageController.changeDate(
                pageController.focusedDay.value.add(const Duration(days: 1)));
          },
          icon: const Icon(Icons.arrow_right),
        ),
        Expanded(child: Container()),

        /// 试图切换的按钮，按下弹出选择框
        _buildDropdownButton(),

        IconButton(
          onPressed: () {
            pageController.changeDate(DateTime.now());
          },
          icon: const Icon(Icons.today),
        ),
      ],
    );
  }

  Widget _buildDropdownButton() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(
          pageController.currentMenuItem.value.icon,
          color: Colors.black,
        ),
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          // 强制转换
          pageController.changeCurrentMenuItem(value as MenuItem);
          pageController.changeViewMode(value.viewMode);
        },
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.redAccent,
          ),
          offset: const Offset(0, 8),
        ),
      ),
    );
  }
}

/// 枚举，用于表示当前的视图模式
enum ViewMode {
  timeLine,
  timeGrid,
}

class MenuItem {
  const MenuItem({
    required this.viewMode,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
  final ViewMode viewMode;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [
    grid,
    timeline,
  ];

  static const grid =
      MenuItem(text: '时间块', icon: Icons.grid_3x3, viewMode: ViewMode.timeGrid);
  static const timeline =
      MenuItem(text: '时间线', icon: Icons.timeline, viewMode: ViewMode.timeLine);
  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
