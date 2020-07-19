import 'package:flutter/material.dart';

void main() => runApp(MyApp2());

class MyApp extends StatelessWidget {
  String data = "我好帅!";

  MyApp() {
    Future.delayed(Duration(seconds: 3)).then((s) {
      this.data = "Lance最帅!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("哈哈"),
        ),
        body: Center(
          child: Text(data),
        ),
      ),
    );
  }
}

/// 提供状态更新
class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {

  String data = "我好帅!";

  _MyApp2State() {
    ///Future： Event队列
    Future.delayed(Duration(microseconds: 1)).then((s) {
      debugPrint("1111111111111111");
      this.data = "Lance最帅!";
      ///修改状态 updateState  刷新ui，重绘，调用build方法
      setState(() {
        debugPrint("2222222222222222");
      });
    });
    ///不允许在构造方法中setState，因为State都还没有，如何刷新？
//    setState(() {
//      debugPrint("2222222222222222");
//    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build========");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("哈哈"),
        ),
        body: Center(
          child: Text(data),
        ),
      ),
    );
  }
}
