import 'package:flutter/material.dart';

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
        color = Color(json['color']).withAlpha(255),
        categoryId = json['categoryId'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = name;
    data['color'] = color.value;
    data['categoryId'] = categoryId;
    return data;
  }
}
