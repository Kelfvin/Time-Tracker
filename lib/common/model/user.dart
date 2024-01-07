import 'package:time_tracker/common/model/event_category.dart';

class User {
  int? id;
  String? username;
  String? avatar;
  String? group;
  String? password;
  List<EventCategory> categories;

  User({
    this.id,
    this.username,
    this.avatar,
    this.group,
    this.password,
    this.categories = const [],
  });

  User.fromJson(Map<String, dynamic> json) : categories = [] {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
    group = json['group'];
    password = json['password'];
    if (json['categories'] != null) {
      categories = <EventCategory>[];
      json['categories'].forEach((v) {
        categories.add(EventCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? 0;
    data['username'] = username ?? "";
    data['avatar'] = avatar ?? "";
    data['group'] = group ?? "";
    data['password'] = password ?? "";

    return data;
  }

  static User empty() {
    return User(id: 0, username: "", avatar: "", group: "", password: "");
  }

  @override
  String toString() {
    return "User{id: $id, username: $username, avatar: $avatar, group: $group, password: $password}";
  }
}
