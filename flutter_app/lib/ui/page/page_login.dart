import 'package:flutter/material.dart';
import 'package:flutter_app/ui/page/page_register.dart';
import 'package:flutter_app/net/api.dart';
import 'package:toast/toast.dart';
import 'package:flutter_app/event/events.dart';
import 'package:flutter_app/event/event_manager.dart';
import 'package:flutter_app/manager/app_manager.dart';

///{data: {admin: false, chapterTops: [], coinCount: 0, collectIds: [], email: , icon: , id: 73649, nickname: qianjin123, password: , publicName: qianjin123, token: , type: 0, username: qianjin123}, errorCode: 0, errorMsg: }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _userName = "";
  String _userPwd = "";
  var _formKey = GlobalKey<FormState>();

  FocusNode _userNameNode = FocusNode();
  FocusNode _userPwdNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("登录页", style: TextStyle(fontSize: 20))),
      body: _buildLogin(),
    );
  }

  Widget _buildLogin() {
    return Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: <Widget>[
            //用户名：
            _buildUserName(),
            //用户密码：
            _buildUserPwd(),
            //登录按钮
            _buildLoginBtn(),
            //注册按钮
            _buildRegister()
          ],
        ));
  }

  Widget _buildUserName() {
    return TextFormField(
      autofocus: true,
      focusNode: _userNameNode,
      decoration: InputDecoration(labelText: "用户名"),
      initialValue: _userName,
      //设置键盘回车为下一步
      textInputAction: TextInputAction.next,
      //点击键盘回车的回调
      onEditingComplete: (){
         FocusScope.of(context).requestFocus(_userPwdNode);
      },
      //文本输入监听
      validator: (value) {
        _userName = value;
        if (value == null || value.trim().isEmpty) {
          return "请输出用户名";
        }
        return null;
      },
    );
  }

  Widget _buildUserPwd() {
    return TextFormField(
      autofocus: true,
      focusNode: _userPwdNode,
      decoration: InputDecoration(labelText: "用户密码"),
      initialValue: _userPwd,
      //设置键盘回车为下一步
      textInputAction: TextInputAction.go,
      //点击键盘回车的回调
      onEditingComplete: (){
        _onClickLogin();
      },
      //文本输入监听
      validator: (value) {
        _userPwd = value;
        if (_userName.isNotEmpty && value.trim().isEmpty) {
          return "请输出用户名密码";
        }
        return null;
      },
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 18, left: 8, right: 8),
      child: RaisedButton(
        color: Colors.blue,
        onPressed: _onClickLogin,
        child: Text(
          "登录",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRegister() {
    return Container(
        margin: EdgeInsets.only(left: 12, right: 12, top: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "如果还没有注册",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            InkWell(
              onTap: _onClickRegister,
              child: Text(
                "请先注册",
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
            )
          ],
        ));
  }

  _onClickLogin() async{
     _userNameNode.unfocus();
     _userPwdNode.unfocus();
     if(_formKey.currentState.validate()){
       //测试通过调用登录接口
       Map result = await Api.login(_userName, _userPwd);
       print("flutter: 注册数据结构 : $result");
       if (result["errorCode"] == 0) {
         Toast.show("登录成功！", context, gravity: Toast.CENTER);
         //本地缓存
         AppManager.setUserName(_userName);
         //eventBus通知
         EventManater.eventBus.fire(LoginEvent(_userName));
         Navigator.pop(context, _userName);
       } else {
         Toast.show(result["errorMsg"], context, gravity: Toast.CENTER);
       }
     }
  }

  _onClickRegister() {
    Future<String> future =
        Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RegisterPage();
    }));
    future.then((value){
       if(null != value && value.trim().isNotEmpty){
          _userName = value;
          setState(() {
          });
       }
    });
  }
}
