class Action {
  int? id;
  String? name;
  int? color;

  int? categoryId;

  Action({this.id, this.name, this.color, this.categoryId});

  Action.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['categoryId'] = this.categoryId;
    return data;
  }
}