import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:time_tracker/page/time_line/time_line_page.dart';

class TimeLinePageController extends GetxController {
  var currentMenuItem =
      MenuItem(icon: Icons.grid_3x3, text: "时间格", viewMode: ViewMode.timeGrid)
          .obs;

  void changeCurrentMenuItem(MenuItem value) {
    currentMenuItem.value = value;
  }
}
