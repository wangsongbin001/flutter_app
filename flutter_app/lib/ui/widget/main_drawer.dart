import 'package:flutter/material.dart';
import 'package:flutter_app/util/str_tools.dart';
import 'package:flutter_app/ui/page/page_login.dart';
import 'package:flutter_app/event/event_manager.dart';
import 'package:flutter_app/event/events.dart';
import 'package:flutter_app/net/api.dart';
import 'package:toast/toast.dart';
import 'package:flutter_app/manager/app_manager.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String _username = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _username = AppManager.userName;
    EventManater.eventBus.on<LoginEvent>().listen((loginEvent) {
       _username = loginEvent.userName;
       setState(() {
       });
    });
  }

  @override
  Widget build(BuildContext context) {
    //整体是一个ListView
    Widget header = DrawerHeader(
        //背景
        decoration: BoxDecoration(color: Colors.blue),
        child: InkWell(
          onTap: _onHeaderClick,
          child: Column(
            children: <Widget>[
              SizedBox(
                  width: 70,
                  height: 70,
                  child: CircleAvatar(

                      ///AssetImage的使用，1，创建响应的文件；2，在pubsepec.yaml文件中注册
                      backgroundImage: AssetImage("assets/images/logo.png"),
                      radius: 38)),
              InkWell(
                  onTap: () => {},
                  child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(isEmpty(_username) ? "请先登录" : _username,
                          style: TextStyle(fontSize: 14, color: Colors.white))))
            ],
          ),
        ));

    return Drawer(
        child: ListView(
            //不设置会导致状态栏灰色
            padding: EdgeInsets.zero,
            children: <Widget>[
          header,
          //收藏
          InkWell(
            onTap: () => {},
            child: ListTile(
              leading: Icon(Icons.favorite),
              title: Text("收藏", style: TextStyle(fontSize: 16)),
            ),
          ),
          //灰色下划线
          Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Divider(color: Colors.grey),
          ),
          //退出按钮
          Offstage(
            offstage: isEmpty(_username),
            child: InkWell(
              onTap: _onLogout,
              child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("退出", style: TextStyle(fontSize: 16))),
            ),
          )
        ]));
  }

  void _onHeaderClick() {
    if (isEmpty(_username)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    }
  }

  void _onFavoriteClick() {

  }

  void _onLogout() async{
    Map result = await Api.logout();
    if(result["errorCode"] == 0){
      Toast.show("退出成功", context, gravity: Toast.CENTER);
      //重置数据更新UI
      _username = "";
      AppManager.clearUserInfo();
      setState(() {
      });
    }else{
      Toast.show(result["errorMsg"], context, gravity: Toast.CENTER);
    }
  }
}
