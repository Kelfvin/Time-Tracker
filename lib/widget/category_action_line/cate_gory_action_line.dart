import 'package:flutter/material.dart';

import 'category_button.dart';

class CategoryActionLine extends StatelessWidget {
  // 生成一个Column,里面每个元素是一个项目，如学习、洗漱、睡觉等，最好能美化一下
  List<Widget> generateWidget() {
    List<Widget> widgets = [];
    List<String> titles = ["学习", "洗漱", "睡觉", "吃饭", "运动", "打游戏", "看电影", "看书"];

    
    const List<Color> colors = [
      Color.fromARGB(255, 204, 224, 255), // Pastel Blue
      Color.fromARGB(255, 255, 204, 229), // Pastel Pink
      Color.fromARGB(255, 204, 255, 204), // Pastel Green
      Color.fromARGB(255, 255, 255, 204), // Pastel Yellow
      Color.fromARGB(255, 229, 204, 255), // Pastel Purple
      Color.fromARGB(255, 255, 229, 204), // Pastel Orange
      Color.fromARGB(255, 204, 255, 229), // Pastel Mint
      Color.fromARGB(255, 229, 204, 255), // Pastel Lavender
    ];
    for (int i = 0; i < 24; i++) {
      widgets.add(Container(
        decoration: BoxDecoration(
          color: colors[i % 8],
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        margin: const EdgeInsets.all(2),
        height: 40,
        child: Text(
          titles[i % 8],
          textAlign: TextAlign.center,
        ),
      ));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [CategoryButton()],
    );
  }
}
