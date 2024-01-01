import 'package:flutter/material.dart';

class EventButton extends StatelessWidget {
  final String title;
  final Color color;
  final Duration? duration;

  const EventButton(
      {super.key, required this.title, required this.color, this.duration});

  /// 时间间隔格式化输出
  /// 30秒
  /// 1分钟30秒
  /// 1小时30分钟30秒
  /// 1天1小时30分钟
  String formatDuration(Duration duration) {
    String result = "";
    if (duration.inDays > 0) {
      result += "${duration.inDays}天";
    }
    if (duration.inHours > 0) {
      result += "${duration.inHours % 24}小时";
    }
    if (duration.inMinutes > 0) {
      result += "${duration.inMinutes % 60}分钟";
    }
    if (duration.inSeconds > 0) {
      result += "${duration.inSeconds % 60}秒";
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Material(
        color: color,
        child: Ink(
          height: 60,
          width: 100,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title),
                // 时间间隔格式化输出，比如 1小时30分钟

                Text(
                  formatDuration(
                    duration ?? Duration.zero,
                  ),
                  style: const TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
