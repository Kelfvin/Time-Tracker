import "package:flutter/material.dart";
import "package:time_tracker/common/model/event.dart";
import "package:time_tracker/common/model/record.dart";

class DataUtils {
  /// 生成测试数据
  static List<Record> generateTestRecords() {
    List<Record> records = [
      Record(
          id: 1,
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 0, 0, 0, 0),
          endTime: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            7,
            45,
          ),
          event: Event(name: "睡觉", color: const Color(0xff41e28c), categoryId: 1),
          eventId: 1),
      Record(
          id: 2,
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 7, 45, 1, 1),
          endTime: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            10,
            22,
          ),
          event: Event(name: "工作", color: const Color(0xff41e28c), categoryId: 2),
          eventId: 2),
      Record(
          id: 3,
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 10, 22, 1, 1),
          endTime: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            12,
            30,
          ),
          event: Event(name: "吃饭", color: const Color(0xfff66c89), categoryId: 3),
          eventId: 3),
      Record(
          id: 4,
          startTime: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            12,
            30,
          ),
          endTime: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            13,
            00,
          ),
          event: Event(name: "工作", color: const Color(0xff41e28c), categoryId: 2),
          eventId: 2),
    ];
    return records;
  }
}
