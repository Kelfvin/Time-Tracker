import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/controller/user_controller.dart';

class Utils {
  static Dio dio = Get.find();
  static UserController userManager = Get.find();

  /// 格式化时间
  static String formatDurationTime(Duration? duration) {
    if (duration == null) {
      return "0秒";
    }
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
    if (duration.inSeconds >= 0) {
      result += "${duration.inSeconds % 60}秒";
    }
    return result;
  }

  // 解析 ISO 8601 时间间隔
  static Duration parseDuration(String? durationString) {
    if (durationString == null) {
      return Duration.zero;
    }
    RegExp regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?');
    Match match = regex.firstMatch(durationString) as Match;

    int hours = int.parse(match[1] ?? '0');
    int minutes = int.parse(match[2] ?? '0');
    int seconds = int.parse(match[3] ?? '0');

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}

class HexColor {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }
}
