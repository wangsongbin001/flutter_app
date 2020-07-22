import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter_app/net/dio_http.dart';
import 'package:flutter_app/net/api.dart';

main(){
  String url = r"wxarticle/chapters/json";
  get(url);
  print("after get()");
}

get(String url) async{
  print("get 1");
  Map reponse = await Api.getArticleList(1);
  if(reponse != null){
    Map data = reponse["data"];
    if(data != null) {
      print(data['curPage']);
      List data1 = data["datas"];
      data1.forEach((item) {
        print(item["title"]);
      });
    }
  }
  print("get 2 data:" + reponse.toString());
}