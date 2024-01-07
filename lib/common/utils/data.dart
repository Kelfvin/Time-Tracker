import "package:flutter/material.dart";
import 'package:time_tracker/common/model/event_category.dart';
import "package:time_tracker/common/model/event.dart";
import 'package:time_tracker/common/model/event_record.dart';

class DataUtils {
  ///高亮颜色
  static const List<Color> colors = [
    Color(0xff2eaefd),
    Color(0xff41e28c),
    Color(0xfff66c89),
    Color(0xfffdc33f),
    Color(0xffa25ddc),
    Color(0xff2eaefd),

    // 转成10进制
    // 4281249533,
    // 4278223103,
    // 4294967295,
    // 4294339721,
    // 4294967295,
    // 4278223103,
  ];

  /// 生成测试数据
  static List<EventRecord> generateTestRecords() {
    List<EventRecord> records = [
      EventRecord(
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
          event:
              Event(name: "睡觉", color: const Color(0xff41e28c), categoryId: 1),
          eventId: 1),
      EventRecord(
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
          event:
              Event(name: "工作", color: const Color(0xff41e28c), categoryId: 2),
          eventId: 2),
      EventRecord(
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
          event:
              Event(name: "吃饭", color: const Color(0xfff66c89), categoryId: 3),
          eventId: 3),
      EventRecord(
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
          event:
              Event(name: "工作", color: const Color(0xff41e28c), categoryId: 2),
          eventId: 2),
    ];
    return records;
  }

  /// 生成Event测试数据
  static List<Event> generateTestEvents() {
    List<String> names = [
      "学习",
      "工作",
      "吃饭",
      "睡觉",
      "运动",
      "娱乐",
    ];
    List<Event> events = [];
    for (int i = 0; i < 6; i++) {
      Event event = Event(
        name: names[i],
        color: colors[i],
        categoryId: 1,
      );
      events.add(event);
    }
    return events;
  }

  static Map<String, dynamic> testJson = {
    "categorys": [
      {
        "id": 1,
        "name": "积极",
        "events": [
          {"id": 1, "name": "运动", "categoryId": 1, "color": "#2eaefd"},
          {"id": 2, "name": "看书", "categoryId": 1, "color": "#41e28c"},
          {"id": 3, "name": "编程", "categoryId": 1, "color": "#f66c89"},
          {"id": 4, "name": "听播客", "categoryId": 1, "color": "#fdc33f"}
        ]
      },
      {
        "id": 2,
        "name": "消极",
        "events": [
          {"id": 5, "name": "黑洞", "categoryId": 2, "color": "#a25ddc"},
          {"id": 6, "name": "玩游戏", "categoryId": 2, "color": "#2eaefd"},
          {"id": 7, "name": "看视频", "categoryId": 2, "color": "#2eaefd"}
        ]
      },
      {
        "id": 3,
        "name": "日常",
        "events": [
          {"id": 8, "name": "吃饭", "categoryId": 3, "color": "#a25ddc"},
          {"id": 9, "name": "睡觉", "categoryId": 3, "color": "#2eaefd"},
          {"id": 10, "name": "洗漱", "categoryId": 3, "color": "#2eaefd"}
        ]
      }
    ]
  };

  /// 生成category测试数据
  static List<EventCategory> generateTestCategories() {
    // 字符串转json
    Map<String, dynamic> json = testJson;
    List<dynamic> categorys = json['categorys'];
    List<EventCategory> categories = [];
    for (var item in categorys) {
      EventCategory category = EventCategory.fromJson(item);
      categories.add(category);
    }
    return categories;
  }
}
