import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:flutter/services.dart";
import 'package:time_tracker/page/group/user_item.dart';

/// 显示小组的页面
class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Card(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "小组名称",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "小组介绍",
                      style: TextStyle(fontSize: 15),
                    ),
                    Row(children: [
                      const Text("小组号："),
                      // 一个复制按钮,
                      const Text("xawjidowj"),
                      IconButton(
                          onPressed: () {
                            // 复制小组号到剪切
                            Clipboard.setData(const ClipboardData(text: "aaa"));
                            // 吐司提示
                            Get.snackbar(
                              "复制成功",
                              "小组号已经复制到剪切板",
                            );
                          },
                          icon: const Icon(
                            Icons.copy,
                            size: 15,
                          ))
                    ]),
                  ]),
            ),
          ),
          const UserItem()
        ],
      ),
    );
  }
}
