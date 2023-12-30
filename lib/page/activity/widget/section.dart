import 'package:flutter/material.dart';
import 'package:time_tracker/page/activity/widget/event_button.dart';

class Section extends StatelessWidget {
  String title = "null";
  List<EventButton> buttons = [];

  Section(
      {super.key, required String title, required List<EventButton> buttons}) {
    this.title = title;
    this.buttons = buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
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
