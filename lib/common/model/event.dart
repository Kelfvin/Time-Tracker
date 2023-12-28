import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Event {

  // 自增长的id
  final int id;
  final DateTime startTimestamp;
  final DateTime endTimestamp;

  Event(
      {required this.id,
      required this.startTimestamp,
      required this.endTimestamp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startTimestamp': startTimestamp.millisecondsSinceEpoch,
      'endTimestamp': endTimestamp.millisecondsSinceEpoch,
    };
  }

  static Event fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      startTimestamp:
          DateTime.fromMillisecondsSinceEpoch(map['startTimestamp']),
      endTimestamp: DateTime.fromMillisecondsSinceEpoch(map['endTimestamp']),
    );
  }

  @override
  String toString() {
    return 'Event{id: $id, startTimestamp: $startTimestamp, endTimestamp: $endTimestamp}';
  }
}
