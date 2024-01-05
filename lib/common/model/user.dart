class User {
  int? id;
  String? username;
  String? avatar;
  String? group;
  String? password;

  User({
    this.id,
    this.username,
    this.avatar,
    this.group,
    this.password,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
    group = json['group'];
    password = json['password'];
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

  String toString() {
    return "User{id: $id, username: $username, avatar: $avatar, group: $group, password: $password}";
  }
}
