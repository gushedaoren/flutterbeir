

import 'package:flutter/material.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/widgets/PrivacyWebViewPage.dart';

class Mydialog{

  BuildContext context;


  Mydialog(this.context);

  showAlert(title) {

    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(

          title: new Text(title),
//          content: WebView(
//
//            initialUrl: BRConfig.PRIVACY_URL,
//            javascriptMode: JavascriptMode.unrestricted,
//          ),
          actions: <Widget>[
            new RawMaterialButton(
              child: new Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

}
