import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String title;
  final double progress;
  final String time;
  final Color color;

  const Item(
      {super.key,
      required this.title,
      required this.progress,
      required this.time,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // 去掉边缘阴影和边缘的线
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(child: Text(title[0])),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            color: color,
            value: progress,
          )
        ],
      ),
      trailing: Text(time, style: const TextStyle(fontSize: 12)),
    );
  }
}

class ListChart extends StatelessWidget {
  const ListChart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 20),
        Item(
            title: "睡觉", progress: 0.5, time: "10小时", color: Color(0xfff67280)),
        Item(title: "吃饭", progress: 0.1, time: "1小时", color: Color(0xfff8b195)),
        Item(title: "学习", progress: 0.2, time: "2小时", color: Color(0xff74b49b)),
        Item(
            title: "打游戏", progress: 0.3, time: "3小时", color: Color(0xff4b87b9)),
      ],
    );
  }
}
