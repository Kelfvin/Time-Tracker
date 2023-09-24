import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class TimegridPage extends GetView<TimegridController> {
  const TimegridPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("TimegridPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimegridController>(
      init: TimegridController(),
      id: "timegrid",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("timegrid")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
