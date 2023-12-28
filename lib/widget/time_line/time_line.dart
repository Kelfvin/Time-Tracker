import 'package:flutter/material.dart';

class TimeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// 生成0到24的时间column

    List<Widget> widgets = [];
    for (int i = 0; i < 24; i++) {
      widgets.add(Expanded(
        child: Text("$i:00"),
      ));
    }

    return Column(
      children: widgets,
    );
  }
}
