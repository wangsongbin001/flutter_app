//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:wanandroid/event/events.dart';
//import 'package:wanandroid/http/api.dart';
//import 'package:wanandroid/manager/app_manager.dart';
//import 'package:wanandroid/ui/page/page%20_login.dart';
//import 'package:wanandroid/ui/page/page_collect.dart';
//
//class MainDrawer extends StatefulWidget {
//  @override
//  _MainDrawerState createState() => _MainDrawerState();
//}
//
//class _MainDrawerState extends State<MainDrawer> {
//  String _username;
//
//  @override
//  void initState() {
//    super.initState();
//    //监听特定的事件：LoginEvent
//    AppManager.eventBus.on<LoginEvent>().listen((event) {
//      setState(() {
//        _username = event.username;
//        //sp sharedprefrence
//        AppManager.prefs.setString(AppManager.ACCOUNT, _username);
//      });
//    });
//    _username = AppManager.prefs.getString(AppManager.ACCOUNT);
//  }
//
//  void _itemClick(Widget page) {
//    //如果未登录 则进入登陆界面
//    var dstPage = _username == null ? LoginPage() : page;
//    //如果page为null，则跳转
//    if (dstPage != null) {
//      Navigator.push(context, new MaterialPageRoute(builder: (context) {
//        return dstPage;
//      }));
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    Widget userHeader = DrawerHeader(
//      decoration: BoxDecoration(
//        color: Colors.blue,
//      ),
//      child: InkWell(
//        /// 点击进入登录界面
//        onTap: () => _itemClick(null),
//        child: Column(
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.only(bottom: 18.0),
//              child: CircleAvatar(
//                backgroundImage: AssetImage("images/logo.png"),
//                radius: 38.0,
//              ),
//            ),
//            Text(
//              _username ?? "请先登录",
//              style: TextStyle(color: Colors.white, fontSize: 18.0),
//            )
//          ],
//        ),
//      ),
//    );
//    return ListView(
//
//      ///不设置会导致状态栏灰色
//      padding: EdgeInsets.zero,
//      children: <Widget>[
//
//        ///头部
//        userHeader,
//
//        ///收藏
//        InkWell(
//          onTap: () => _itemClick(CollectPage()),
//          child: ListTile(
//            leading: Icon(Icons.favorite),
//            title: Text('收藏列表', style: TextStyle(fontSize: 16.0)),
//          ),
//        ),
//        Padding(
//          padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
//          child: Divider(
//            color: Colors.grey,
//          ),
//        ),
//
//        ///退出登录
//        Offstage(
//          offstage: _username == null,
//          child: InkWell(
//            onTap: () {
//              setState(() {
//                AppManager.prefs.setString(AppManager.ACCOUNT, null);
//                Api.clearCookie();
//                _username = null;
//              });
//            },
//            child: ListTile(
//              leading: Icon(Icons.exit_to_app),
//              title: Text('退出登录', style: TextStyle(fontSize: 16.0)),
//            ),
//          ),
//        )
//      ],
//    );
//  }
//}
