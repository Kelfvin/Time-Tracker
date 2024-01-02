import 'package:dio/dio.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:time_tracker/common/model/event.dart';
import 'package:time_tracker/common/model/record.dart';

class RecordDao {
  static final Dio dio = Get.find(tag: "dio");

  /// 获取用户某一天的记录
  static Future<List<Record>> getRecordsByDate(DateTime date) async {
    var response = await dio.get("/record/getRecordsByDate", queryParameters: {
      "date": date.millisecondsSinceEpoch,
    });

    if (response.data["success"]) {
      List<Record> records = [];
      for (var item in response.data["data"]) {
        records.add(Record.fromJson(item));
      }
      return records;
    }

    return [];
  }

  /// 开启一个新的记录
  static Future<Record?> startRecord(Event event) async {
    var response = await dio.post("/record/startRecord", data: {
      "eventId": event.id,
    });

    if (response.data["success"]) {
      return Record.fromJson(response.data["data"]);
    }

    return null;
  }

  /// 结束一个记录
  static Future<Record?> endRecord(Record record) async {
    var response = await dio.post("/record/endRecord", data: {
      "recordId": record.id,
    });

    if (response.data["success"]) {
      return Record.fromJson(response.data["data"]);
    }

    return null;
  }
}
