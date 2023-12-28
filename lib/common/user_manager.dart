import "dart:convert";

import "package:dio/dio.dart";
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:time_tracker/bean/user.dart';
import "package:time_tracker/common/routes/app_pages.dart";

class UserManager {
  User? user;
  String? token;
  Dio dio = Get.find(tag: "dio");

  /// 保存用户信息到本地
  storeUser(User user) async {
    if (user == null) {
      return;
    }

    this.user = user;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", json.encode(user.toJson()));
  }

  /// 保存token到本地
  storeToken(String token) async {
    token = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  /// 从本地加载用户信息
  loadUser() async {
    print("从本地加载用户信息");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userBean = prefs.getString("user");
    if (userBean == null) {
      return;
    }

    user = User.fromJson(json.decode(userBean));
  }

  /// 注销，清除用户信息和token
  logout() async {
    user = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user");
    await prefs.remove("token");
    Get.offAllNamed(AppPages.LoginRegister);
  }

  /// 从本地加载token
  /// 如果token过期，返回null
  /// 如果token有效，返回token
  loadToken() async {
    print("从本地加载token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (token == null) {
      return;
    }

    this.token = token;
  }

  /// 检查登录状态
  checkLogin() async {
    await loadUser();
    await loadToken();

    if (user == null || token == null) {
      print("用户未登录！");
      Get.offAllNamed(AppPages.LoginRegister);
      return;
    }

    // 验证token是否有效

    try {
      var response = await dio.get("/user/checkLogin", queryParameters: {
        "token": token,
      });

      if (!response.data["success"]) {
        print("用户未登录！");
        Get.offAllNamed(AppPages.LoginRegister);
        return;
      }

      print("$response.data[\"message\"] 用户已登录！");
    } catch (e) {
      print(e);
    }
  }
}
