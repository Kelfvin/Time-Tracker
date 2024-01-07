import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/controller/user_controller.dart';
import 'package:time_tracker/common/dao/record_dao.dart';
import 'package:time_tracker/common/model/event_record.dart';

class RecordController extends GetxController {
  final UserController userManager = Get.find();
  var records = <EventRecord>[].obs;

  // 当前正在运行的记录
  Rx<EventRecord?> currentRecord = Rx<EventRecord?>(null);

  // 请求正在运行的记录
  Future<EventRecord?> fetchCurrentRecord() async {
    currentRecord.value = await RecordDao.getCurrentRecord();
    return currentRecord.value;
  }

  // 开始一个记录
  Future<EventRecord?> startRecord(int eventId) async {
    currentRecord.value = await RecordDao.startRecord(eventId);

    return currentRecord.value;
  }

  // 结束一个记录
  Future<EventRecord?> endRecord() async {
    if (currentRecord.value == null) {
      return null;
    }

    RecordDao.endRecord(currentRecord.value!.id!);

    currentRecord.value = null;

    return currentRecord.value;
  }

  // 获取某一天的记录
  void fetchRecordByDay(DateTime day) async {
    if (kDebugMode) {
      print("fetchRecordByDay");
    }
    records.value = await RecordDao.getRecordsByDate(day);
  }
}
