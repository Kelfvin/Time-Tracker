import 'package:flutter/material.dart';
import 'package:time_tracker/page/activity/widget/event_button.dart';

class Section extends StatelessWidget {
  final String title;
  final List<EventButton> buttons;

  const Section({super.key, required this.title, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          // 上下间隔
          runSpacing: 10,
          children: buttons,
        )
      ],
    );
  }
}
