import 'package:flutter/material.dart';

///Navigator operation requested with a context that does not include a Navigator.
///直接调用会抛出异常，因为Navigator.of(context)，Context的父节点，不含Navigator;
///解决方法1，使用Builder包裹一层，context的父节点就是MaterialApp；
///解决方法2，使用StatelessWidget包一层，本质和上面是一样的；
///解决方法3，GlobalKey;在MatericalApp中申明navigatorKey:globalkey;


void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  final GlobalKey<NavigatorState> globalKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: globalKey,
        title: "第一个page", //退到后台后，recenttask中展示的标题
        home: Scaffold(
            appBar: AppBar(title: Text("第一个page")),
            body: Center(
                child: RaisedButton(
                    onPressed: () {
                      print("onPressed");
//                      Navigator.push(context, new MaterialPageRoute(builder: (context){
//                        return Page2();
//                      }));
                       globalKey.currentState.push(new MaterialPageRoute(builder: (context){
                         return Page2();
                       }));

                    },
                    child: Text("点击跳转第二个界面"))
            )
        )
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("第一个page")),
//            body: Builder(builder: (context) {
//              return Center(
//                  child: RaisedButton(
//                      onPressed: () {
//                        print("onPressed");
//                        Navigator.of(context).push(
//                            new MaterialPageRoute(
//                                builder: (_) {
//                                  return Page2();
//                                }
//                            )).then((v){
//                              print(v);
//                        });
//                      },
//                      child: Text("点击跳转第二个界面"))
//              );
//            })
        body: Center(
            child: RaisedButton(
                onPressed: () {
                  print("onPressed");
                  Navigator.push(context, new MaterialPageRoute(builder: (context){
                    return Page2();
                  }));
                },
                child: Text("点击跳转第二个界面"))
        )
    );
  }
}


class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "第二个page", //退到后台后，recenttask中展示的标题
        home: Scaffold(
            appBar: AppBar(title: Text("第二个page")),
            body: Center(
                  child: RaisedButton(
                      onPressed: () {
                        print("onPressed");
//                        Navigator.push(context, new MaterialPageRoute(builder: (context){
//                          return Page3();
//                        }));
                         Navigator.of(context).pop();
                      },
                      child: Text("点击返回第一个"))
              )
            )
        );
  }
}

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "第二个page", //退到后台后，recenttask中展示的标题
        home: Scaffold(
            appBar: AppBar(title: Text("第三个page")),
            body: Center(
                child: RaisedButton(
                    onPressed: () {
                      print("onPressed");
                      Navigator.of(context).pop(PageResult(0, "hello world"));
                    },
                    child: Text("点击返回第一个"))
            )
        )
    );
  }
}


class PageResult{
    int code;
    String data;
    PageResult(this.code, this.data);
}

