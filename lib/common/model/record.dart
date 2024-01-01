import 'package:time_tracker/common/model/event.dart';

class Record {
  int id;
  DateTime startTime;
  DateTime endTime;
  Event event;
  int eventId;

  Record({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.event,
    required this.eventId,
  });

  Record.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        startTime = DateTime.fromMillisecondsSinceEpoch(json['startTime']),
        endTime = DateTime.fromMillisecondsSinceEpoch(json['endTime']),
        event = Event.fromJson(json['event']),
        eventId = json['eventId'];

  // 获取开始时间，格式化输出
  String getStartTime() {
    return "${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}";
  }

  // 获取结束时间，格式化输出
  String getEndTime() {
    return "${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}";
  }
}
