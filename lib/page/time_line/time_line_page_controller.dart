import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/page/time_line/time_line_page.dart';

class TimeLinePageController extends GetxController {
  var focusedDay = DateTime.now().obs;

  var currentViewMode = ViewMode.timeGrid.obs;

  var currentMenuItem = const MenuItem(
          icon: Icons.grid_3x3, text: "时间格", viewMode: ViewMode.timeGrid)
      .obs;

  void changeCurrentMenuItem(MenuItem value) {
    currentMenuItem.value = value;
  }

  void changeViewMode(ViewMode viewMode) {
    currentViewMode.value = viewMode;
  }

  void changeDate(DateTime date) {
    focusedDay.value = date;
  }

  void changeDateToToday() {
    focusedDay.value = DateTime.now();
  }

  void changeDateToNextDay() {
    focusedDay.value = focusedDay.value.add(const Duration(days: 1));
  }

  void changeDateToPreviousDay() {
    focusedDay.value = focusedDay.value.subtract(const Duration(days: 1));
  }

  void changeDateToNextWeek() {
    focusedDay.value = focusedDay.value.add(const Duration(days: 7));
  }

  void changeDateToPreviousWeek() {
    focusedDay.value = focusedDay.value.subtract(const Duration(days: 7));
  }
}
