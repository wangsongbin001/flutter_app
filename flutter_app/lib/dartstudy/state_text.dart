import 'package:flutter/material.dart';

class StateText extends StatefulWidget {
  String str;

  StateText.txt(this.str);

  @override
  _StateTextState createState() => _StateTextState.txt(str);
}

class _StateTextState extends State<StateText> {

// state的生命周期，
// initState ：当widget第一次被插入widget树中时的回调，只会调用一次
// didChangeDependencies : 当依赖的InheritedWidget rebuild,会触发此接口被调用.没太理解
// build : 绘制界面，setState（）后回调；
// didUpdateWidget : 当parent状态改变时，例如Parent.setState（）后回调；
// deactivate : 当state对象被从树中移除时 回调；
// dispose : 当state对象被从树中永久性移除时 回调；
  String str;

  @override
  void initState() {
    super.initState();
    print("child initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("child didChangeDependencies");
  }

  @override
  void didUpdateWidget(StateText oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("child didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("child deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("child dispose");
  }

  _StateTextState.txt(this.str);

  @override
  Widget build(BuildContext context) {
    return Text("hello 生命周期 $str");
  }
}

