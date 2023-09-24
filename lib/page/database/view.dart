import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class DatabasePage extends GetView<DatabaseController> {
  const DatabasePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return ListView(
      children: [
        for (var item in controller.events)
          ListTile(
            title: Text(item.startTimestamp.toString()),
            subtitle: Text(item.endTimestamp.toString()),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatabaseController>(
      init: DatabaseController(),
      id: "database",
      builder: (_) {
        return Scaffold(
            appBar: AppBar(title: const Text("database")),
            body: SafeArea(
              child: _buildView(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: controller.addRecord,
              child: const Icon(Icons.add),
            ));
      },
    );
  }
}
