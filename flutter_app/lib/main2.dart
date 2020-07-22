import 'package:flutter/material.dart';

void main(){
  runApp(MyApp2());
}

//Widget的功能是描述一个UI元素的配置数据；
//StatelessWidget/StatefulWidget 无状态/有状态；
class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
//    return new Text('hello world',
//      textDirection: TextDirection.ltr);
    return MaterialApp(
        title: 'hello world',
        home: Scaffold(
            appBar: AppBar(title: Text('第一个futter界面')),
            body: Center(child: Text("我真帅", textAlign: TextAlign.center)))
    );
  }
}

//StatefulWidget 返回一个state
class MyApp3 extends StatefulWidget {
  @override
  _MyApp3State createState() => _MyApp3State();
}

//state的生命周期，
// initState ：当widget第一次被插入widget树中时的回调，只会调用一次
// didChangeDependencies : 当依赖的InheritedWidget rebuild,会触发此接口被调用.没太理解
// build : 绘制界面，setState（）后回调；
// didUpdateWidget : 状态改变时，setState（）后回调；
// deactivate : 当state对象被从树中移除时 回调；
// dispose : 当state对象被从树中永久性移除时 回调；
class _MyApp3State extends State<MyApp3> {

  String txt;

  @override
  void initState() {
    print("initState");
    super.initState();
    txt = "你好，之华";
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(MyApp3 oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return MaterialApp(
      title: 'widget演示',
      theme: ThemeData(),
      home: Scaffold(
          appBar: AppBar(title: Text('你好')),
          body: Center(
              child: RaisedButton(
                  onPressed: (){
                    txt = "你好，我是之华";
                    setState(() {
                      print("wangs setState");
                    });
                  },
                  child: Text('点我改变状态, $txt')))
      ),
    );
  }
}