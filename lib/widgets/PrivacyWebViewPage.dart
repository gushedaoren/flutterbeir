import 'package:flutter/material.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class PrivacyWebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<PrivacyWebViewPage> {
  // 获取项目中的html文件
  Future<String> _getFile() async {
    return "";
  }

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
// initialUrl 这里有个bug.如果你使用本地html的话,html中不能使用汉语. 使用服务器提供的url的话可以使用汉语.....
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: WebView(
              initialUrl:
              BRConfig.PRIVACY_URL,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              javascriptChannels: <JavascriptChannel>[
                _alertJavascriptChannel(context),
              ].toSet(),
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('js://webview')) {
                  print('js call flutter1');
                  print(request);
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
            ),
            floatingActionButton: jsButton(),
          );
        } else {
          return Text('获取本地html失败');
        }
      },
    );
  }

  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'shaoting',
        onMessageReceived: (JavascriptMessage message) {
          print('js call flutter2');
          print(message.message);
        });
  }

  Widget jsButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                _controller.future.then((controller) {
                  controller
                      .evaluateJavascript('callJS("Flutter call JS")')
                      .then((result) {});
                });
              },
              child: Text('call JS'),
            );
          }
          return Container();
        });
  }
}