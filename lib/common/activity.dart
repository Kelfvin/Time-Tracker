import "package:get/get.dart";
import "package:time_tracker/common/model/event.dart";
import "package:time_tracker/common/model/record.dart";

/// 当前正在进行的任务管理

class ActivityConrtoller extends GetxController {
  /// 当前正在进行的任务
  Record? currentActivity;

  var currentActivityDuration = const Duration(seconds: 0).obs;

  /// 定时器更新当前任务的时间
  void updateCurrentActivityDuration() {
    if (currentActivity != null) {
      currentActivityDuration.value =
          DateTime.now().difference(currentActivity!.startTime);
    }
  }

  @override
  void onInit() {
    super.onInit();
    // 每秒更新一次
    ever(currentActivityDuration, (_) {
      updateCurrentActivityDuration();
    });
  }

  /// 开始一个新的任务
  void startNewActivity(Event event) {
    print("开始新的任务 ${event.name}");

    // 结束当前任务
    endCurrentActivity();

    // 向服务器发送请求
    // TODO 记录当前任务的开始时间

    currentActivity =
        Record(event: event, startTime: DateTime.now(), eventId: event.id!);

    currentActivityDuration.value =
        DateTime.now().difference(currentActivity!.startTime);
  }

  /// 结束当前任务
  void endCurrentActivity() {
    // 向服务器发送请求
    // TODO 记录当前任务的结束时间

    currentActivity = null;
    currentActivityDuration.value = const Duration(seconds: 0);
  }

  /// 判断当前是否有任务正在进行
  bool get isActivitying => currentActivity != null;
}
