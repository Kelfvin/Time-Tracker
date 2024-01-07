import 'package:time_tracker/common/model/event.dart';

class EventRecord {
  int? id;
  DateTime startTime;
  DateTime? endTime;
  Event event;
  int eventId;

  EventRecord({
    this.id,
    required this.startTime,
    this.endTime,
    required this.event,
    required this.eventId,
  });

  EventRecord.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        startTime = DateTime.parse(json['startTimestamp']),
        event = Event.fromJson(json['event']),
        eventId = json['eventId'] {
    if (json['endTimestamp'] != null) {
      endTime = DateTime.parse(json['endTimestamp']);
    }
    
  }

  // 获取开始时间，格式化输出
  String getStartTime() {
    return "${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}";
  }

  // 获取结束时间，格式化输出
  String getEndTime() {
    if (endTime == null) {
      return "未结束";
    }
    return "${endTime?.hour.toString().padLeft(2, '0')}:${endTime?.minute.toString().padLeft(2, '0')}";
  }
}
