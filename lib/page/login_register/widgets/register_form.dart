import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:time_tracker/page/login_register/controller.dart';
import 'package:time_tracker/page/login_register/enum.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({Key? key}) : super(key: key);
  final LoginRegisterController loginRegisterController =
      Get.find(tag: "loginRegisterController");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '注册',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        TextField(
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
        ),
        const SizedBox(height: 30),
        TextField(
          obscureText: loginRegisterController.obscureText.value,
          decoration: InputDecoration(
            hintText: '密码',
            suffixIcon: const Icon(
              Icons.visibility_off_outlined,
              color: Colors.grey,
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
        ),
        const SizedBox(height: 40),
        // 忘记密码和注册
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                loginRegisterController.pageForm.value = PageForm.login;
              },
              child: const Text(
                "登录",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),

        Container(
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
            onPressed: loginRegisterController.onRegister,
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
                child: Center(child: Text("注册"))),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
