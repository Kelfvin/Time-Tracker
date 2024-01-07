import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:time_tracker/common/model/event_record.dart';
import 'package:intl/intl.dart';

class RecordDao {
  static final Dio dio = Get.find();

  /// 获取用户某一天的记录
  static Future<List<EventRecord>> getRecordsByDate(DateTime date) async {
    // 把日期转换成yyyy-MM-dd格式，如2021-09-09
    String formatDate = DateFormat("yyyy-MM-dd").format(date);

    Response response;

    try {
      response = await dio.get("/record/day", queryParameters: {
        "date": formatDate,
      });

      if (response.data["success"]) {
        List<EventRecord> records = [];
        for (var item in response.data["data"]["recordOfDay"]) {
          records.add(EventRecord.fromJson(item));
        }
        return records;
      }
    } on DioException catch (e) {
      // 处理

      Get.snackbar("请求错误", e.response!.data["message"]);
    } catch (e) {
      // 处理
      Get.snackbar("错误", "未知错误");
    }

    return [];
  }

  /// 开启一个新的记录
  static Future<EventRecord?> startRecord(int eventId) async {
    try {
      var response = await dio.post("/record/start", queryParameters: {
        "eventId": eventId,
      });

      if (response.data["success"]) {
        return EventRecord.fromJson(response.data["data"]["record"]);
      }
    } on DioException catch (e) {
      // 处理
      Get.snackbar("开始记录失败", e.response!.data["message"]);
    }

    return null;
  }

  /// 结束一个记录
  static Future<EventRecord?> endRecord(int recordId) async {
    try {
      var response = await dio.post("/record/end", queryParameters: {
        "recordId": recordId,
      });

      if (response.data["success"]) {
        return EventRecord.fromJson(response.data["data"]["record"]);
      }
    } on DioException catch (e) {
      // 处理
      Get.snackbar("错误", e.response!.data["message"]);
    }

    return null;
  }

  static getCurrentRecord() async {
    try {
      var response = await dio.get("/record/current");

      if (response.data["success"]) {
        return EventRecord.fromJson(response.data["data"]["record"]);
      }
    } on DioException catch (e) {
      // 处理
      Get.snackbar("获取当前记录错误", e.response!.data["message"]);
    }
  }
}
