import "dart:async";

import "package:get/get.dart";
import "package:time_tracker/common/controller/record_controller.dart";


/// 当前正在进行的任务管理

class ActivityConrtoller extends GetxController {
  final RecordController recordController = Get.find();

  var currentActivityDuration = const Duration(seconds: 0).obs;

  /// 定时器更新当前任务的时间
  void updateCurrentActivityDuration() {
    if (recordController.currentRecord.value != null) {
      currentActivityDuration.value = DateTime.now()
          .difference(recordController.currentRecord.value!.startTime);
    }
  }

  @override
  void onInit() {
    super.onInit();

    // 每秒更新一次
    // 设置定时器，每秒更新一次时间
    Timer.periodic(const Duration(seconds: 1), (timer) {
      updateCurrentActivityDuration();
    });
  }
}
