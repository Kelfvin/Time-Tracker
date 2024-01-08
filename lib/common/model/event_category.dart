

import 'package:flutter/material.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/common/utils/utils.dart';

class EventCategory {
  int? id;
  String name;
  List<Event>? events;

  Duration? duration;

  late Color color;

  EventCategory({this.id, required this.name, this.events}) {
    events = [];
    color = Colors.grey;
  }

  EventCategory.fromJson(Map<String, dynamic> json) : name = json['name'] {
    id = json['id'];
    if (json['events'] != null) {
      events = <Event>[];
      json['events'].forEach((v) {
        events!.add(Event.fromJson(v));
      });

      if (json['color'] != null) {
        color = HexColor.fromHex(json['color']);
      } else {
        color = Colors.grey;
      }

      if (json['duration'] != null) {
        // 解析标准时间,使用库解析
        duration = Utils.parseDuration(json['duration']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = this.id;
    data['name'] = name;
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
