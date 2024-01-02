import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:time_tracker/common/model/user.dart';

class UserDao {
  static Dio dio = Get.find(tag: "dio");

  static Future<Response> login(User user) async {
    var data = {
      "username": user.username,
      "password": user.password,
    };

    try {
      var response = await dio.post("/user/login", data: data);
      return response;
    } catch (e) {
      // 处理
    }

    return Response(
      requestOptions: RequestOptions(path: ""),
      data: {"success": false},
    );
  }

  /// 验证token是否有效
  static Future<bool> validateToken(String token) async {
    try {
      var response = await dio.get("/user/checkLogin", queryParameters: {
        "token": token,
      });

      if (!response.data["success"]) {
        return false;
      }
    } catch (e) {
      //
    }

    return true;
  }
}
