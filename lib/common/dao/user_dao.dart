import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_tracker/common/controller/user_controller.dart';
import 'package:time_tracker/common/model/user.dart';

class UserDao {
  static Dio dio = Get.find();
  static UserController userController = Get.find();

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
      if (kDebugMode) {
        return Response(
          requestOptions: RequestOptions(path: ""),
          data: {"success": false, "message": "网络错误"},
        );
        // 处理 connect failed
      }
    }

    return Response(
      requestOptions: RequestOptions(path: ""),
      data: {"success": false, "message": "未知错误"},
    );
  }

  /// 验证token是否有效
  /// 如果有效，返回用户信息
  /// 如果无效，返回null
  static Future<User?> loginByToken(String token) async {
    try {
      var response = await dio.get("/user/loginByToken", queryParameters: {
        "token": token,
      });

      if (!response.data["success"]) {
        return null;
      }

      return User.fromJson(response.data["data"]["user"]);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      //
      return null;
    }
  }

  /// 上传文件
  static Future<bool> updateAvatar(XFile file) async {
    String url = "/user/updateAvatar";
    String token = userController.token.value;

    MultipartFile avatar;

    // 如果是web平台，需要把file转换成bytes
    if (kIsWeb) {
      avatar = MultipartFile.fromBytes(await file.readAsBytes(),
          filename: file.name, contentType: MediaType("image", "jpeg"));
    } else {
      avatar = await MultipartFile.fromFile(file.path,
          filename: file.name, contentType: MediaType("image", "jpeg"));
    }

    // 判断文件的大小,不能超过5M
    if (avatar.length > 5 * 1024 * 1024) {
      Get.snackbar("上传失败", "图片不能超过5M");
      return false;
    }

    FormData formData = FormData.fromMap({
      "avatar": avatar,
      "token": token,
    });

    try {
      var response = await dio.put(url, data: formData);

      if (kDebugMode) {
        print(response);
      }

      return response.data["success"];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
