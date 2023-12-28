import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/model/category.dart';
import 'package:time_tracker/common/model/event.dart';

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
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Ink(
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
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  Event action;

  ActionButton({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      text: action.name ?? "null",
      onTap: () {},
      color: Color(action.color ?? 0xffffff),
    );
  }
}

/// 一个类别的按钮列表，点击类别可以展开子类别
class CategoryButton extends StatelessWidget {
  VoidCallback? onTap;

  Category category;

  var isExpanded = false.obs;

  CategoryButton({Key? key, this.onTap, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button(
          text: category.name ?? "null",
          onTap: () => isExpanded.value = !isExpanded.value,
          icon: Icons.arrow_drop_down,
          // 高级颜色
          color: Color(0xffe0e0e0),
        ),
        _buildActionList(),
      ],
    );
  }

  Widget _buildActionList() {
    return Obx(() {
      if (isExpanded.value) {
        return Column(
          children: [
            for (Event action in category.events!) ActionButton(action: action)
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
