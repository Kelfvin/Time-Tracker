import 'package:dio/dio.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:time_tracker/common/model/category.dart';

class CategoryDao {
  static final Dio dio = Get.find(tag: "dio");

  /// 获取用户的所有分类
  static Future<List<Category>> getCategories() async {
    var response = await dio.get("/category/getCategories");

    if (response.data["success"]) {
      List<Category> categories = [];
      for (var item in response.data["data"]) {
        categories.add(Category.fromJson(item));
      }
      return categories;
    }

    return [];
  }
}
