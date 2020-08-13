//import 'dart:io';
//
//import 'package:cookie_jar/cookie_jar.dart';
//import 'package:dio/dio.dart';
//import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:flutter_app/cankao/http/api.dart';
//
//class HttpManager {
//  Dio _dio;
//  static HttpManager _instance;
//
//  PersistCookieJar _persistCookieJar;
//
//  factory HttpManager.getInstance() {
//    if (null == _instance) {
//      _instance = new HttpManager._internal();
//    }
//    return _instance;
//  }
//
//  //以 _ 开头的函数、变量无法在库外使用
//  HttpManager._internal() {
//    BaseOptions options = new BaseOptions(
//      baseUrl: Api.baseUrl, //基础地址
//      connectTimeout: 5000, //连接服务器超时时间，单位是毫秒
//      receiveTimeout: 3000, //读取超时
//    );
//    _dio = new Dio(options);
//   _initDio();
//  }
//
//  void _initDio() async {
//    Directory directory = await getApplicationDocumentsDirectory();
//    var path = Directory(join(directory.path, "cookie")).path;
//    _persistCookieJar = PersistCookieJar(dir: path);
//    _dio.interceptors.add(CookieManager(_persistCookieJar));
//  }
//
//  request(url, {data, String method = "get"}) async {
//    try {
//      Options option = new Options(method: method);
//      Response response = await _dio.request(url, data: data, options: option);
//      print(response.request.headers);
//      print(response.data);
//      return response.data;
//    } catch (e) {
//      print(e);
//      return null;
//    }
//  }
//
//  void clearCookie() {
//    _persistCookieJar.deleteAll();
//  }
//}
//
//
//
//
//
