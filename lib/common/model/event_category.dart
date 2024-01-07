import 'package:time_tracker/common/model/event.dart';

class EventCategory {
  int? id;
  String name;
  List<Event>? events;

  int? color;

  EventCategory({this.id, required this.name, this.events, this.color}) {
    events = [];
  }

  EventCategory.fromJson(Map<String, dynamic> json) : name = json['name'] {
    id = json['id'];
    if (json['events'] != null) {
      events = <Event>[];
      json['events'].forEach((v) {
        events!.add(Event.fromJson(v));
      });
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
