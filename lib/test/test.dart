import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:time_tracker/bean/user.dart';




void main() {
  
  var dio = Dio();
  dio.get("http://www.baidu.com").then((value) => print(value.data));
  
  
}


