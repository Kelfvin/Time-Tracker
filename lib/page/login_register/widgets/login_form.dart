import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:time_tracker/page/login_register/controller.dart";
import "package:time_tracker/page/login_register/enum.dart";

class LoginRegisterForm extends StatelessWidget {
  LoginRegisterForm({Key? key}) : super(key: key);
  final LoginRegisterController loginRegisterController =
      Get.find(tag: "loginRegisterController");

  Widget buildForm() {
    return Column(
      children: [
        const Text(
          '登录时光迹',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        buildUsernameInput(),
        const SizedBox(height: 30),
        buildPasswordInput(),
        const SizedBox(height: 40),
        // 忘记密码和注册
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (kDebugMode) {
                  print("忘记密码");
                }
              },
              child: const Text(
                "忘记密码",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                loginRegisterController.pageForm.value =
                    PageForm.register; // 切换到注册页面
              },
              child: const Text(
                "注册",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        buildLoginButton(),
        const SizedBox(height: 40),
      ],
    );
  }

  Container buildLoginButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple[100]!,
            spreadRadius: 10,
            blurRadius: 20,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: loginRegisterController.onLogin,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const SizedBox(
            width: double.infinity,
            height: 50,
            child: Center(child: Text("登录"))),
      ),
    );
  }

  TextField buildPasswordInput() {
    return TextField(
      // 密码
      obscureText: loginRegisterController.obscureText.value,
      decoration: InputDecoration(
        hintText: '密码',
        suffixIcon: IconButton(
          icon: Icon(
            loginRegisterController.obscureText.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.grey,
          ),
          color: Colors.grey,
          onPressed: () {
            loginRegisterController.obscureText.value =
                !loginRegisterController.obscureText.value;
          },
        ),
        filled: true,
        fillColor: Colors.blueGrey[50],
        labelStyle: const TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.only(left: 30),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey[50]!),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey[50]!),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onChanged: loginRegisterController.onPasswordChanged,
      onSubmitted: (value) {
        loginRegisterController.onLogin();
      },
    );
  }

  TextField buildUsernameInput() {
    return TextField(
      decoration: InputDecoration(
        hintText: '输入用户名',
        filled: true,
        fillColor: Colors.blueGrey[50],
        labelStyle: const TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.only(left: 30),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey[50]!),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey[50]!),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onChanged: loginRegisterController.onUserNameChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => buildForm());
  }
}
