import 'package:flutter/material.dart';
import 'package:flutter_app/manager/app_manager.dart';
import 'package:flutter_app/ui/widget/main_drawer.dart';
import 'ui/page/page_article.dart';

void main() => runApp(new ArticleApp());

class ArticleApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppManager.initApp();
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            '文章',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        drawer: Drawer(
          child: MainDrawer(),
        ),
//        body: new ArticlePage(),
      ),
    );
  }


}
