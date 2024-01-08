import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StatisticPageController extends GetxController {
  final dateRangeMode = DateRangeMode.day.obs;

  final dateRange = Rxn<DateTimeRange>();

  StatisticPageController() {
    final now = DateTime.now();
    dateRange.value = DateTimeRange(
      start: DateTime(now.year, now.month, now.day),
      end: DateTime(now.year, now.month, now.day, 23, 59, 59),
    );
  }

  void changeDateRangeMode(DateRangeMode mode) {
    dateRangeMode.value = mode;

    // 根据模式，设置时间范围
    // 如果是日模式，设置时间范围为当天，起始时间是今天0点，结束时间是今天23:59:59
    // 如果是周模式，设置时间范围为本周，起始时间为周一,结束时间是本周日
    // 如果是月模式，设置时间范围为本月，起始时间为1号，结束时间是本月最后一天
    // 如果是年模式，设置时间范围为本年，起始时间为1月1号，结束时间是12月31号
    final now = DateTime.now();
    switch (mode) {
      case DateRangeMode.day:
        dateRange.value = DateTimeRange(
          start: DateTime(now.year, now.month, now.day),
          end: DateTime(now.year, now.month, now.day, 23, 59, 59),
        );
        break;
      case DateRangeMode.week:
        final weekDay = now.weekday;
        dateRange.value = DateTimeRange(
          start: DateTime(now.year, now.month, now.day - weekDay + 1),
          end: DateTime(now.year, now.month, now.day + (7 - weekDay)),
        );
        break;
      case DateRangeMode.month:
        dateRange.value = DateTimeRange(
          start: DateTime(now.year, now.month, 1),
          end: DateTime(now.year, now.month + 1, 0),
        );
        break;
      case DateRangeMode.year:
        dateRange.value = DateTimeRange(
          start: DateTime(now.year, 1, 1),
          end: DateTime(now.year, 12, 31),
        );
        break;
    }
  }

  /// 向前切换时间范围的逻辑，根据当前是日、周、月、年模式，切换到上一时间范围
  /// 例如：当前是日模式，切换到上一天；当前是周模式，切换到上一周
  void previousDateRange() {
    final currentRange = dateRange.value;
    if (currentRange == null) {
      return;
    }

    switch (dateRangeMode.value) {
      case DateRangeMode.day:
        dateRange.value = DateTimeRange(
          start: currentRange.start.subtract(const Duration(days: 1)),
          end: currentRange.end.subtract(const Duration(days: 1)),
        );
        break;
      case DateRangeMode.week:
        dateRange.value = DateTimeRange(
          start: currentRange.start.subtract(const Duration(days: 7)),
          end: currentRange.end.subtract(const Duration(days: 7)),
        );
        break;
      case DateRangeMode.month:
        dateRange.value = DateTimeRange(
          start: DateTime(
            currentRange.start.year,
            currentRange.start.month - 1,
          ),
          end: DateTime(
            currentRange.end.year,
            currentRange.end.month - 1,
          ),
        );
        break;
      case DateRangeMode.year:
        dateRange.value = DateTimeRange(
          start: DateTime(
            currentRange.start.year - 1,
            currentRange.start.month,
          ),
          end: DateTime(
            currentRange.end.year - 1,
            currentRange.end.month,
          ),
        );
        break;
    }
  }

  /// 向后切换时间范围的逻辑，根据当前是日、周、月、年模式，切换到下一时间范围
  void nextDateRange() {
    final currentRange = dateRange.value;
    if (currentRange == null) {
      return;
    }

    switch (dateRangeMode.value) {
      case DateRangeMode.day:
        dateRange.value = DateTimeRange(
          start: currentRange.start.add(const Duration(days: 1)),
          end: currentRange.end.add(const Duration(days: 1)),
        );
        break;
      case DateRangeMode.week:
        dateRange.value = DateTimeRange(
          start: currentRange.start.add(const Duration(days: 7)),
          end: currentRange.end.add(const Duration(days: 7)),
        );
        break;
      case DateRangeMode.month:
        dateRange.value = DateTimeRange(
          start: DateTime(
            currentRange.start.year,
            currentRange.start.month + 1,
          ),
          end: DateTime(
            currentRange.end.year,
            currentRange.end.month + 1,
          ),
        );
        break;
      case DateRangeMode.year:
        dateRange.value = DateTimeRange(
          start: DateTime(
            currentRange.start.year + 1,
            currentRange.start.month,
          ),
          end: DateTime(
            currentRange.end.year + 1,
            currentRange.end.month,
          ),
        );
        break;
    }
  }

  // 获取格式化后的时间范围
  String getFormattedDateRange() {
    final currentRange = dateRange.value;
    if (currentRange == null) {
      return "null";
    }

    if (dateRangeMode.value == DateRangeMode.year ||
        dateRangeMode.value == DateRangeMode.month) {
      DateFormat format = DateFormat("yyyy.MM");
      return "${format.format(currentRange.start)}-${format.format(currentRange.end)}";
    }

    DateFormat format = DateFormat("yyyy.MM.dd");
    return "${format.format(currentRange.start)} - ${format.format(currentRange.end)}";
  }
}

class DateRangeMode {
  static const day = DateRangeMode._("日");
  static const week = DateRangeMode._("周");
  static const month = DateRangeMode._("月");
  static const year = DateRangeMode._("年");

  final String _value;

  const DateRangeMode._(this._value);

  @override
  String toString() => _value;
}
