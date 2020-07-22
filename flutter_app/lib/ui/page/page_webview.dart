import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  WebData _data;

  WebViewPage.Data(this._data);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoaded = true;
  FlutterWebviewPlugin flutterWebviewPlugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("**********************");
    print(widget._data._title);
    print(widget._data._url);
    print("**********************");
    flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onStateChanged.listen((state) {
      print(state.type);
      if (state.type == WebViewState.finishLoad) {
        // 加载完成
        setState(() {
          isLoaded = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoaded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        appBar: AppBar(
            title: Text(widget._data._title),
            bottom: PreferredSize(
                child: const LinearProgressIndicator(),
                preferredSize: const Size.fromHeight(1.0)),
            bottomOpacity: isLoaded ? 1.0 : 0.0),
        url: widget._data._url,
        withLocalStorage: true, //缓存
        withJavascript: true //交互
        );
  }
}

class WebData {
  String _url;
  String _title;

  WebData(this._title, this._url);
}
