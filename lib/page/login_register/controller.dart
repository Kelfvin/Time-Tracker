import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker/common/dao/user_dao.dart';
import 'package:time_tracker/common/model/user.dart';
import 'package:time_tracker/common/user_manager.dart';
import 'package:time_tracker/page/login_register/enum.dart';

class LoginRegisterController extends GetxController {
  var user = User.empty().obs;
  // 全局的UserManager
  UserManager userManager = Get.find(tag: "userManager");

  Dio dio = Get.find(tag: "dio");

  /// 用于监视当前页面的表单是登录还是注册
  var pageForm = PageForm.login.obs; // 默认是登录页面

  /// 是否显示密码
  var obscureText = true.obs;

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
    var response = await UserDao.login(user.value);


    // 如果登录成功
    if (response.data["success"]) {
      await userManager.storeToken(response.data["data"]["token"]);
      await userManager.loginByToken();
      // 跳转到主页
      Get.snackbar("登录成功", response.data["message"], colorText: Colors.green);
      Get.offAllNamed("/home");
    } else {
      // 登录失败
      Get.snackbar("登录失败", response.data["message"]);
    }
  }

  /// 用户注册
  void onRegister() async {
    if (kDebugMode) {
      print("onRegister");
      print(user.value.username);
      print(user.value.password);
    }

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
      if (kDebugMode) {
        print(e);
      }
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
