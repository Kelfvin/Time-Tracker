import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String title;
  const TextInput({super.key, required this.title, this.onChanged});
  // 回调函数
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 10,
        ),
        TextField(
          onChanged: onChanged,
          // 设置高度
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

