import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/model/event_category.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/page/time_line/timegrid/timgrid_controller.dart';

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
      child: Material(
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
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (icon != null) Icon(icon),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EventButton extends StatelessWidget {
  final Event event;

  final TimegridController timegridController = Get.find();

  EventButton({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      text: event.name,
      onTap: () {
        timegridController.addRecord(event);
      },
      color: event.color,
    );
  }
}

/// 一个类别的按钮列表，点击类别可以展开子类别
class CategoryButton extends StatelessWidget {
  final EventCategory category;

  final isExpanded = true.obs;

  CategoryButton({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Button(
              text: category.name,
              onTap: () => isExpanded.value = !isExpanded.value,
              icon: isExpanded.value
                  ? Icons.arrow_drop_up
                  : Icons.arrow_drop_down,
              // 高级颜色
              color: const Color(0xffe0e0e0),
            ),
            _buildEventList(),
          ],
        ));
  }

  Widget _buildEventList() {
    return Obx(() {
      if (isExpanded.value) {
        return Column(
          children: [
            for (Event event in category.events!) EventButton(event: event)
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
