//import 'package:flutter/material.dart';
//import 'package:wanandroid/http/api.dart';
//
//class CollectPage extends StatefulWidget {
//  @override
//  _CollectPageState createState() => _CollectPageState();
//}
//
//class _CollectPageState extends State<CollectPage> {
//  int _curPage = 0;
//  bool _isHidden = false;
//
//  //收藏
//  List _collects;
//
//  @override
//  void initState() {
//    super.initState();
//    _getCollects();
//  }
//
//  void _getCollects() async {
//    var data = await Api.getCollects(_curPage);
//    _isHidden = true;
//    _collects = data['datas'];
//    setState(() {});
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("我的收藏"),
//      ),
//      body: Stack(
//        children: <Widget>[
//          Offstage(
//            offstage: _isHidden,
//            child: Center(
//              child: CircularProgressIndicator(),
//            ),
//          ),
//          Offstage(
//            ///如果请求到了收藏数据并且不为空就隐藏，否则显示
//            offstage: _collects?.isNotEmpty ?? !_isHidden,
//            child: Center(
//              child: Text("(＞﹏＜) 你还没有收藏任何内容......"),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}
