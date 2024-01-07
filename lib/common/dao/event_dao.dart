import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
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
}
