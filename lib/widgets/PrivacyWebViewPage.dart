import 'package:flutter/material.dart';
import 'package:flutterbeir/config/BRConfig.dart';

import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';



class PrivacyWebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<PrivacyWebViewPage> {
  // 获取项目中的html文件
  Future<String> _getFile() async {
    return "";
  }


// initialUrl 这里有个bug.如果你使用本地html的话,html中不能使用汉语. 使用服务器提供的url的话可以使用汉语.....
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WebView(
            initialUrl: BRConfig.PRIVACY_URL,
            javascriptMode: JavascriptMode.unrestricted,
          );
        } else {
          return Text('获取本地html失败');
        }
      },
    );
  }


}