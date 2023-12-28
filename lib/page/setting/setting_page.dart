import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:time_tracker/common/user_manager.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  UserManager userManager = Get.find(tag: "userManager");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SettingsList(sections: [
      SettingsSection(
        title: Text('账户'),
        tiles: [
          SettingsTile(
            title: const Text('退出登录'),
            leading: const Icon(Icons.exit_to_app),
            onPressed: (BuildContext context) {
              userManager.logout();
            },
          ),
        ],
      ),
    ]));
  }
}
