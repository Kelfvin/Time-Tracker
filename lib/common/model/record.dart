import 'package:time_tracker/common/model/event.dart';

class Record {
  int id;
  DateTime startTime;
  DateTime endTime;
  Event event;
  int eventId;

  Record(
      {required this.id,
      required this.startTime,
      required this.endTime,
      required this.event,
      required this.eventId});
}
