import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutter_app/net/api.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _userName = "";
  String _userPwd = "";
  String _userPwd2 = "";
  FocusNode _userNameNode = FocusNode();
  FocusNode _userPwdNode = FocusNode();
  FocusNode _userPwd2Node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("注册页", style: TextStyle(fontSize: 20))),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              children: <Widget>[
                //用户名：
                _buildUserName(),
                //用户密码：
                _buildUserPwd(),
                //登录按钮
                _buildUserPwd2(),
                //注册按钮
                _buildRegister()
              ],
            )));
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
      onEditingComplete: () {
        //把焦点给密码框
        _userNameNode.unfocus();
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
      decoration: InputDecoration(labelText: "用户密码"),
      initialValue: _userPwd,
      //设置键盘回车为下一步
      textInputAction: TextInputAction.next,
      //点击键盘回车的回调
      onEditingComplete: () {
        //把焦点给确认密码框
        _userPwdNode.unfocus();
        FocusScope.of(context).requestFocus(_userPwd2Node);
      },
      //文本输入监听
      validator: (value) {
        _userPwd = value;
        if (_userName.trim().isNotEmpty && value.trim().isEmpty) {
          return "请输出用户密码";
        }
        return null;
      },
    );
  }

  Widget _buildUserPwd2() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(labelText: "确认密码"),
      initialValue: _userPwd2,
      //设置键盘回车为下一步
      textInputAction: TextInputAction.go,
      //点击键盘回车的回调
      onEditingComplete: () {
        _userPwd2Node.unfocus();
        _onClickRegister();
      },
      //文本输入监听
      validator: (value) {
        _userPwd2 = value;
        if (_userPwd.isNotEmpty && _userPwd != _userPwd2) {
          return "两次输入密码不一样";
        }
        return null;
      },
    );
  }

  Widget _buildRegister() {
    return Container(
        height: 40,
        margin: EdgeInsets.only(left: 12, right: 12, top: 18),
        child: RaisedButton(
          onPressed: _onClickRegister,
          color: Colors.blue,
          child: Text(
            "注册",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ));
  }

  void _onClickRegister() async {
    _userNameNode.unfocus();
    _userPwdNode.unfocus();
    _userPwd2Node.unfocus();

    if (_formKey.currentState.validate()) {
      //{data: null, errorCode: -1, errorMsg: 用户名已经被注册！}
      print("flutter: 注册数据结构 : $_userName $_userPwd");
      Map result = await Api.register(_userName, _userPwd);
      print("flutter: 注册数据结构 : $result");
      if (result["errorCode"] == 0) {
        Toast.show("注册成功！", context, gravity: Toast.CENTER);
        Navigator.pop(context, _userName);
      } else {
        Toast.show(result["errorMsg"], context, gravity: Toast.CENTER);
      }
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _userNameNode.unfocus();
    _userPwdNode.unfocus();
    _userPwd2Node.unfocus();
  }
}
