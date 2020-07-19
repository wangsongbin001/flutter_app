import 'package:dio/dio.dart';

void main() async{

  var dio = new Dio();

  Response response = await dio.get("https://www.wanandroid.com/banner/json");


  var list = [1,2,3,4];

  Iterable<String> list2 = list.map((i){
    return "$i";
  });

  List<String> list3 = list2.toList();

}