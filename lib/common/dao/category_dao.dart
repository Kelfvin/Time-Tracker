import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/common/model/event_category.dart';
import 'package:time_tracker/common/controller/user_controller.dart';

class CategoryDao {
  static final Dio dio = Get.find();
  static final UserController userController = Get.find();

  /// 根据日期获取用户的统计
  static Future<List<EventCategory>> fetchCategoriesByDate(
      DateTime date) async {
    // 把日期转换成yyyy-MM-dd格式，如2021-09-09
    String formatDate = DateFormat("yyyy-MM-dd").format(date);

    try {
      var response = await dio.get(
        "/category/getStatistics",
        queryParameters: {
          "startDate": formatDate,
          "endDate": formatDate,
        },
      );

      if (response.data["success"]) {
        List<EventCategory> categories = [];
        for (var item in response.data["data"]["categories"]) {
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

  // 添加分类
  static Future<EventCategory?> addCategory(String name, String color) async {
    try {
      Response response = await dio.post("/category/add", data: {
        "name": name,
        "color": color,
      });

      if (response.data["success"]) {
        return EventCategory.fromJson(response.data["data"]["category"]);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return null;
  }

  /// 删除分类
  static Future<bool> deleteCategory(int categoryId) async {
    try {
      Response response = await dio.delete("/category", queryParameters: {
        "id": categoryId,
      });

      if (response.data["success"]) {
        Get.snackbar("删除成功", "分类已删除");
        return true;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }
}
