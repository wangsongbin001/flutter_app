import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widget/item_article.dart';
import 'package:flutter_app/net/api.dart';
import 'package:flutter_app/ui/widget/item_banner.dart';

class ArticleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "",
        home: Scaffold(
            appBar: AppBar(
                title: Text("文章", style: const TextStyle(color: Colors.white))),
            body: new ArticlePage()));
  }
}

class ArticlePage extends StatefulWidget {
  @override
  _AritclePageState createState() => _AritclePageState();
}

class _AritclePageState extends State<ArticlePage> {
  bool loadSuccess = false;
  //分页加载
  int currentPage = 0;
  //文章列表
  List listArticles = [];
  //banners列表
  List listBanners;

  //滑动监听
  ScrollController _controller = new ScrollController();
  //文章页总数
  int totalCount = 0;       ///文章总数


  @override
  void initState() {
    super.initState();
    //初始化请求数据
    loadSuccess = false;
    _pullToRefresh();
    _controller.addListener((){//加载更多的回调
      ///获得ScrollController监听控件可以可以滚动的最大范围
      double maxScroll = _controller.position.maxScrollExtent;
      ///获得当前位置所在的范围
      double pixels = _controller.position.pixels;
      if(pixels == maxScroll && currentPage < totalCount){
         _getArticleList(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Stack类似Framelayout
    return Stack(children: <Widget>[
      //未加载成功前的提示界面
      Offstage(
        offstage: loadSuccess,
        child: Center(child: CircularProgressIndicator()),
      ),
      Offstage(
          offstage: !loadSuccess,
          child: new RefreshIndicator(
              child: ListView.builder(
                  itemCount: _getItemCount(),
                  itemBuilder: (context, i) => _buildItem(context, i)
                  ,controller: _controller,
              ),

              onRefresh: _pullToRefresh))
    ]);
  }

  int _getItemCount(){
    int itemCount = listArticles != null? listArticles.length : 0;
    itemCount += listBanners != null ? 1: 0;
    print("itemCount $itemCount");
    return itemCount;
  }

  //下啦刷新
  Future<void> _pullToRefresh() async{
    currentPage = 0;
    Iterable<Future> tasks = [_getArticleList(false), _getBanners()];
    await Future.wait(tasks);
    print("_pullToRefresh");
    loadSuccess = true;
    setState(() {});
    return null;
  }

  //获取文章列表
  _getArticleList([bool update = true]) async{
    Map response = await Api.getArticleList(currentPage + 1);
    if(response != null){
      if(response["errorCode"] == 0 && response["data"] != null){
        Map data = response["data"];
        if(currentPage == 0){
          listArticles.clear();
        }
        currentPage = data["curPage"];
        totalCount = data["pageCount"];

        listArticles.addAll(data["datas"]);
        print("curent:$currentPage totalCount:$totalCount update:$update");
      }
      if(update){
        setState(() {});
      }
    }
  }

  //获取banner数据
  _getBanners() async{
    Map response = await Api.getBanners();
    if(response != null){
      if(response["errorCode"] == 0 && response["data"] != null){
        listBanners = response["data"];
        print(listBanners);
      }
    }
  }

  Widget _buildItem(BuildContext context, int i) {
    if(i == 0){
        return MBannerView(listBanners);
    }
    return ArticleItem(listArticles != null? listArticles[i - 1]: null);
  }

}

