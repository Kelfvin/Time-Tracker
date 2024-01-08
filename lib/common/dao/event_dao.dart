import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:time_tracker/common/model/event.dart';

class EventDao {
  static final Dio dio = Get.find();

  // 添加事件
  static Future<Event?> addEvent(
      String name, int categoryId, String color) async {
    try {
      Response response = await dio.post("/event/add", data: {
        "name": name,
        "categoryId": categoryId,
        "color": color,
      });

      return Event.fromJson(response.data["data"]["event"]);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
        print(e.response);
      }
    }

    return null;
  }

  // 删除事件
  static Future<bool> deleteEvent(int id) async {
    try {
      Response response = await dio.delete("/event", queryParameters: {
        "id": id,
      });

      Get.snackbar("删除成功", "事件已删除");
      return response.data["success"];
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
        print(e.response);
      }
    }

    return false;
  }
}
