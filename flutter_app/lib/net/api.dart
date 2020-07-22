import 'package:flutter_app/net/dio_http.dart';


main(){
//  get();
  get2();
  print("after get()");
}

get() async{
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

get2() async{
  print("get 2");
  Map reponse = await Api.getBanners();
  if(reponse != null){
    List data = reponse["data"];
    data.forEach((item){
      print(item["imagePath"]);
    });
  }
}

class Api{
  //首页文章列表
  static const String ARTICLE_LIST = "article/list";
  //首页banner列表
  static const String BANNER = "banner/json";

  static getArticleList (int page) {
    return HttpManager.getInstance().request('$ARTICLE_LIST/$page/json');
  }

  static getBanners(){
    return HttpManager.getInstance().request(BANNER);
  }
}
