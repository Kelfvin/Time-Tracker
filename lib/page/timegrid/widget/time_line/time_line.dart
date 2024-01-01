import 'package:flutter/material.dart';

class TimeLine extends StatelessWidget {
  const TimeLine({super.key});

  @override
  Widget build(BuildContext context) {
// 生成0到24的时间column

    List<Widget> widgets = [];
    for (int i = 0; i < 24; i++) {
      widgets.add(Expanded(
        child: Text(
          "$i",
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: widgets,
    );
  }
}
