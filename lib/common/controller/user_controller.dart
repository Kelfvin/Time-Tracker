import "dart:convert";

import "package:dio/dio.dart";
import "package:flutter/foundation.dart";

import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:time_tracker/common/dao/category_dao.dart";
import "package:time_tracker/common/dao/user_dao.dart";
import "package:time_tracker/common/model/user.dart";
import "package:time_tracker/common/routes/app_pages.dart";
import 'package:time_tracker/common/model/event_category.dart';

class UserController extends GetxController {
  var user = User().obs;
  var token = "".obs;

  var avatarKey = UniqueKey().obs;

  final Dio dio = Get.find();

  final SharedPreferences prefs = Get.find();

  /// 保存类型
  var categories = <EventCategory>[].obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }



  /// 初始化
  init() async {
    await loadToken();
    await loginByToken();
  }

  /// 获取头像
  void getAvater() async {}

  /// 保存用户信息到本地
  storeUser(User user) async {
    this.user.value = user;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", json.encode(user.toJson()));
  }

  /// 保存token到本地
  storeToken(String token) async {
    this.token.value = token;
    await prefs.setString("token", token);
  }

  /// 注销，清除用户信息和token
  logout() async {
    user.value = User.empty();

    await prefs.remove("user");
    await prefs.remove("token");
    Get.offAllNamed(AppPages.loginRegister);
  }

  /// 从本地加载token
  /// 如果token过期，返回null
  /// 如果token有效，返回token
  loadToken() async {
    if (kDebugMode) {
      print("loadToken from local");
    }

    String? token = prefs.getString("token");
    if (token == null) {
      return;
    }

    this.token.value = token;
  }

  /// 检查登录状态
  loginByToken() async {
    // 如果token是空
    if (token.value == "") {
      Get.offAllNamed(AppPages.loginRegister);
      return;
    }

    // 验证token是否有效
    User? resUser = await UserDao.loginByToken(token.value);

    if (resUser == null) {
      Get.offAllNamed(AppPages.loginRegister);
      return;
    }

    // 如果token有效，更新用户信息
    resUser.avatar = "${dio.options.baseUrl}/file/${resUser.id}.jpg";
    user.value = resUser;
  }
}
