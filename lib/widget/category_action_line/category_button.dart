import 'package:flutter/material.dart';

/// 一个按钮类，统一风格
class Button extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  /// 背景颜色
  final Color? color;
  // 图标
  final IconData? icon;

  const Button(
      {Key? key,
      required this.text,
      required this.onTap,
      this.icon,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: SizedBox(
          height: 40,
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Add this line
            children: [
              Text(text),
              if (icon != null) Icon(icon),
            ],
          ),
        ),
      ),
    );
  }
}

/// 一个类别的按钮列表，点击类别可以展开子类别
class CategoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button(
          text: "主类别",
          onTap: () {},
          icon: Icons.arrow_drop_down,
          color: Color.fromARGB(255, 182, 54, 54),
        ),

        // 下面是子类别
      ],
    );
  }
}
