import 'package:flutter/material.dart';
import 'package:time_tracker/common/utils/utils.dart';

class Event {
  int? id;
  String name;
  Color color;
  Duration? duration;
  int categoryId;

  Event(
      {this.id,
      required this.name,
      required this.color,
      this.duration = const Duration(seconds: 0),
      required this.categoryId});

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? "null",
        color = HexColor.fromHex(json['color']),
        categoryId = json['categoryId'] {
    if (json['duration'] != null) {
      duration = Utils.parseDuration(json['duration']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color'] = HexColor.toHex(color);
    data['categoryId'] = categoryId;
    return data;
  }
}
