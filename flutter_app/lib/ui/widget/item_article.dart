import 'package:flutter/material.dart';
import 'package:flutter_app/ui/page/page_webview.dart';

class ArticleItem extends StatelessWidget {
  var itemData;

  ArticleItem(this.itemData);

  @override
  Widget build(BuildContext context) {
    //标题
    String strTitle = itemData != null ? itemData["title"] : "";
    Text title = new Text("$strTitle",
        style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal));

    //行：作者时间
    String author = itemData != null ? itemData["author"] : "";
    String authorTag = "作者：";
    if (author == null || author == "") {
      authorTag = "分享人：";
      author = itemData != null ? itemData["shareUser"] : "";
    }
    String niceDate = itemData != null ? itemData["niceDate"] : "";

    Row row = new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text.rich(TextSpan(children: [
            TextSpan(text: authorTag),
            TextSpan(
                text: author,
                style: TextStyle(color: Theme.of(context).primaryColor))
          ])),
        ),
        Text(niceDate),
      ],
    );

    Column column = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0), child: title),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
          child: row,
        )
      ],
    );

    return InkWell(
        child: new Card(
            elevation: 4.0, //阴影
            child: column),
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context){
            return WebViewPage.Data(new WebData(itemData["title"], itemData["link"]));
          }));
        });
  }
}
