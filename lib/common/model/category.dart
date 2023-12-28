import 'package:time_tracker/common/model/event.dart';

class Category {
  int? id;
  String? name;
  List<Event>? events;

  int? color;

  Category({this.id, this.name, this.events, this.color}) {
    events = [];
  }

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['actions'] != null) {
      events = <Event>[];
      json['events'].forEach((v) {
        events!.add(new Event.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['name'] = this.name;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
