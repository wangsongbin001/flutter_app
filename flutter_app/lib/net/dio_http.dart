import 'package:dio/dio.dart';


class HttpManager{
  static const String baseUrl = "https://www.wanandroid.com/";

  //单例模式
  static HttpManager instance;

  Dio _dio;

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
    _initDio();
  }

  void _initDio(){
    //添加cookie 拦截器
//    _dio.interceptors.add(Cookie)
  }


  request(String url, {data, String method = "GET"}) async{
    try {
      Options options = new Options(method: method);
      Response<Map> response = await _dio.request<Map>(url, data: data, options: options);
      return response.data;
    }catch(e, s){
      print("$e$s");
      return null;
    }
  }
}