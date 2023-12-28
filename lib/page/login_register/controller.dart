import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/bean/user.dart';
import 'package:time_tracker/common/user_manager.dart';
import 'package:time_tracker/page/login_register/enum.dart';

class LoginRegisterController extends GetxController {
  var user = User.empty().obs;
  // 全局的UserManager
  UserManager userManager = Get.find(tag: "userManager");

  Dio dio = Get.find(tag: "dio");

  var pageForm = PageForm.login.obs; // 默认是登录页面

  /// 是否显示密码
  var isShowPassword = false.obs;

  LoginRegisterController();

  _initData() {
    update(["login_register"]);
  }

  // 按下登录切换按钮
  onRegisterToLoginTap() {
    pageForm.value = PageForm.login;
    update(["login_register"]);
  }

  // 按下注册切换按钮
  onLoginToRegisterTap() {
    pageForm.value = PageForm.register;
    update(["login_register"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void onUserNameChanged(String value) {
    user.value.username = value;
  }

  void onPasswordChanged(String value) {
    user.value.password = value;
  }

  /// 用户登录
  void onLogin() async {
    print("onLogin");

    print(user.value.username);
    print(user.value.password);

    // 身份验证
    // 请求登录，得到token

    var data = {
      "username": user.value.username,
      "password": user.value.password,
    };

    try {
      var response = await dio.post("/user/login", data: data);

      // 如果登录成功
      if (response.data["success"]) {
        // 保存token
        User user = User.fromJson(response.data["data"]);
        userManager.storeUser(user);
        userManager.storeToken(response.data["data"]["token"]);

        // 跳转到主页
        Get.snackbar("登录成功", response.data["message"], colorText: Colors.green);
        Get.offAllNamed("/home");
      } else {
        // 登录失败
        Get.snackbar("登录失败", response.data["message"]);
      }
    } catch (e) {
      print(e);
    }
  }

  /// 用户注册
  void onRegister() async {
    print("onRegister");

    print(user.value.username);
    print(user.value.password);

    // 身份验证
    // 请求注册，得到token

    var data = {
      "username": user.value.username,
      "password": user.value.password,
    };

    try {
      var response = await dio.post("/user/register", data: data);

      // 如果注册成功
      if (response.data["success"]) {
        // 切换到登录表单
        pageForm.value = PageForm.login;
        // 提示用户注册成功
        Get.snackbar("注册成功", response.data["message"], colorText: Colors.green);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
