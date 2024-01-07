import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/controller/user_controller.dart';

import 'package:time_tracker/page/time_line/timegrid/timgrid_controller.dart';
import 'package:time_tracker/page/time_line/timegrid/widget/category_event_line/category_event_line.dart';
import 'package:time_tracker/page/time_line/timegrid/widget/time_line_bar/time_line_bar.dart';
import 'package:time_tracker/page/time_line/timegrid/widget/timegrid.dart';

/// 完整的时间格，包含时间轴和时间格，以及类别和事件
class TimeGridView extends StatelessWidget {
  final TimegridController controller =
      Get.put(TimegridController());

  final UserController userController = Get.find();

  TimeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPage();
  }

  Widget _buildPage() {
    return Row(
      children: [
        const TimelistBar(),
        Expanded(child: Timegrid()),
        SizedBox(width: 70, child: CategoryEventLine()),
      ],
    );
  }
}
