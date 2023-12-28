import 'package:time_tracker/bean/action.dart';

class Category {
  int? id;
  String? name;
  List<Action>? actions;

  Category({this.id, this.name, this.actions});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['actions'] != null) {
      actions = <Action>[];
      json['actions'].forEach((v) {
        actions!.add(new Action.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['name'] = this.name;
    if (this.actions != null) {
      data['actions'] = this.actions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
