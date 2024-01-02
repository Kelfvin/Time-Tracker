import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/page/activity/activity_controller.dart';

/// 显示当前正在激活的事件
class ActivatingWidget extends StatelessWidget {
  final ActivityConrtoller activityConrtoller =
      Get.find(tag: "activityConrtoller");

  ActivatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _buildView();
    });
  }

  Widget _buildView() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Row(
          children: [
            _buildLeading(),
            const SizedBox(
              width: 60,
            ),
            Text(
              formatDuration(activityConrtoller.currentActivityDuration.value),
              style: const TextStyle(fontSize: 17),
            ),

            Expanded(child: Container()),

            /// 结束按钮
            const SizedBox(
              width: 20,
            ),
            _buildCompletButton(),
            const SizedBox(width: 20)
          ],
        ),
      ),
    );
  }

  /// 完成按钮
  Widget _buildCompletButton() {
    // 如果没有正在进行的事件，就不显示
    if (activityConrtoller.currentActivity == null) {
      return Container();
    }
    return InkWell(
      onTap: () {
        activityConrtoller.endCurrentActivity();
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff239afc),
        ),
        child: const Icon(Icons.stop, color: Colors.white),
      ),
    );
  }

  Column _buildLeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("正在进行: ", style: TextStyle(fontSize: 17)),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: activityConrtoller.currentActivity == null
                    ? Colors.grey
                    : activityConrtoller.currentActivity!.event.color,
                shape: BoxShape.circle,
              ),
              width: 15,
              height: 15,
            ),
            const SizedBox(
              width: 10,
            ),
            activityConrtoller.currentActivity == null
                ? const Text("暂无事件")
                : Text(
                    activityConrtoller.currentActivity!.event.name,
                    style: const TextStyle(fontSize: 17),
                  )
          ],
        )
      ],
    );
  }

  /// 格式化时间
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
