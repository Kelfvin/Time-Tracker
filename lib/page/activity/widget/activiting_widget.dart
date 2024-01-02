import 'package:flutter/material.dart';

/// 显示当前正在激活的事件
class ActivatingWidget extends StatelessWidget {
  const ActivatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("正在激活", style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    width: 15,
                    height: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("测试事件"),
                ],
              )
            ],
          ),

          const SizedBox(
            width: 60,
          ),
          const Text(
            "00:00:00",
            style: TextStyle(fontSize: 17),
          ),

          Expanded(child: Container()),

          /// 暂停按钮
          const SizedBox(
            width: 200,
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xff239afc),
            ),
            child: const Icon(
              Icons.pause,
              color: Colors.white,
            ),
          )

          /// 结束按钮
          ,
          const SizedBox(
            width: 20,
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xff239afc),
            ),
            child: const Icon(Icons.stop, color: Colors.white),
          )
        ],
      ),
    );
  }
}
