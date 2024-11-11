import 'dart:convert';

import 'package:dio/dio.dart';



class DioUtil {
  static Dio getDio() {
    String plainCredentials = '$customerKey:$customerSecret';
    String base64Credentials = base64Encode(utf8.encode(plainCredentials));
    String authorizationHeader = 'Basic $base64Credentials';
    var dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 45),
        receiveTimeout: const Duration(seconds: 45),
        sendTimeout: const Duration(seconds: 45),
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': authorizationHeader,
        },
      ),
    );
    return dio;
  }
}
