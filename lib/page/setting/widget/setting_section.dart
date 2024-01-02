import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String sectionName;

  final List<Widget> chidren;

  const Section({super.key, required this.sectionName, required this.chidren});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 20, 0, 20),
      child: Column(
        // 左对齐
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            sectionName,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),

          // 流式布局
          Wrap(
            spacing: 20,
            children: chidren,
          )
        ],
      ),
    );
  }
}
