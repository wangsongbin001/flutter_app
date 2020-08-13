import 'package:flutter_app/net/dio_http.dart';
import 'package:dio/dio.dart';

main() {
//  get();
//  get2();
  post3();
  print("after get()");
}

get() async {
  print("get 1");
  Map reponse = await Api.getArticleList(1);
  if (reponse != null) {
    Map data = reponse["data"];
    if (data != null) {
      print(data['curPage']);
      List data1 = data["datas"];
      data1.forEach((item) {
        print(item["title"]);
      });
    }
  }
  print("get 2 data:" + reponse.toString());
}

get2() async {
  print("get 2");
  Map reponse = await Api.getBanners();
  if (reponse != null) {
    List data = reponse["data"];
    data.forEach((item) {
      print(item["imagePath"]);
    });
  }
}

post3() async{
//  Map response = await Api.register("qianjin", "123456");
//  print("register:$response");
//  Map response = await Api.logout();
//  print("register:$response");
}

class Api {
  //首页文章列表
  static const String ARTICLE_LIST = "article/list";

  //首页banner列表
  static const String BANNER = "banner/json";

  //账号体系：注册/登录/退出
  static const String REGISTER = "user/register";
  static const String LOGIN = "user/login";
  static const String LOGOUT = "user/logout/json";

  static getArticleList(int page) {
    return HttpManager.getInstance().request('$ARTICLE_LIST/$page/json');
  }

  static getBanners() {
    return HttpManager.getInstance().request(BANNER);
  }

  static register(String userName, String userPwd) {
    var data = FormData.fromMap(
        {"username": userName, "password": userPwd, "repassword": userPwd});
    return HttpManager.getInstance()
        .request(REGISTER, data: data, method: "post");
  }

  static login(String userName, String userPwd){
    var data = FormData.fromMap(
        {"username": userName, "password": userPwd});
    return HttpManager.getInstance()
        .request(LOGIN, data: data, method: "post");
  }

  static logout(){
    return HttpManager.getInstance().request(LOGOUT, method: "get");
  }
}
