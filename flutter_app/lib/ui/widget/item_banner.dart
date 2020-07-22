import 'package:flutter/material.dart';
import 'package:banner_view/banner_view.dart';
import 'package:flutter_app/ui/page/page_webview.dart';

class MBannerView extends StatelessWidget {
  List listBanners;

  MBannerView(this.listBanners);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = null;
    if (listBanners != null) {
      list = listBanners.map((item) {
        return InkWell(
          child: Image.network(item["imagePath"], fit: BoxFit.cover),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (_){

              return new WebViewPage.Data(WebData(item["title"], item["url"]));
            }));
          },
        );
      }).toList();
    }
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: _buildBannerView(list));
  }

  Widget _buildBannerView(List<Widget> list) {
    return (listBanners != null && listBanners.isNotEmpty)
        ? BannerView(
            list,
            intervalDuration: new Duration(seconds: 3),
          )
        : null;
  }
}
