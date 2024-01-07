import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:time_tracker/common/model/event_category.dart';
import 'package:time_tracker/common/controller/user_controller.dart';

class CategoryDao {
  static final Dio dio = Get.find();
  static final UserController userController = Get.find();

  /// 获取用户的所有分类
  static Future<List<EventCategory>> fetchCategories() async {
    try {
      var response = await dio.get(
        "/category/getAllCategory",
      );

      if (response.data["success"]) {
        List<EventCategory> categories = [];
        for (var item in response.data["data"]["categoryList"]) {
          categories.add(EventCategory.fromJson(item));
        }
        return categories;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }

    return [];
  }
}
