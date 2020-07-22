import 'package:dio/dio.dart';


class HttpManager{
  static const String baseUrl = "http://www.wanandroid.com/";

  //单例模式
  static HttpManager instance;

  factory HttpManager.getInstance(){
    if(instance == null){
      instance = HttpManager._internal();
    }
    return instance;
  }

  HttpManager._internal(){
    //基础配置
    BaseOptions baseOptions = new BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000, //链接超时
      receiveTimeout: 3000  //读取超时
    );
    _dio = new Dio(baseOptions);
  }

  Dio _dio;

  request(String url, {String method = "GET"}) async{
    try {
      Options options = new Options(method: method);
      Response<Map> response = await _dio.request<Map>(url, options: options);
      return response.data;
    }catch(e, s){
      print("$e$s");
      return null;
    }
  }
}