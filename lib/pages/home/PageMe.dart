import 'package:flutter/material.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/utils/CommonUtils.dart';
import 'package:flutterbeir/widgets/MeItem.dart';
import 'package:package_info/package_info.dart';

class PageMe extends StatelessWidget {


  var appVersion="";
  CommonUtils commonUtils=CommonUtils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的'),),
      body: Center(
        child: initPage(),
      ),
    );
  }


  initHeader(){
    return Container(

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/me_header.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(

        height: 180,

        child: Center(
          child:new Container(
            width: 90,
            height: 90,
              child:new Image.asset("assets/images/ic_launcher.png")
          )


        ),
      ),
    );
  }

  void _getVersion() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {

        appVersion = packageInfo.version;

    });
  }



  initPage(){



    return new CustomScrollView(
      shrinkWrap: false,
      // 内容
      slivers: <Widget>[
        new SliverPadding(
          padding: const EdgeInsets.all(0.0),
          sliver: new SliverList(
            delegate: new SliverChildListDelegate(
              <Widget>[
                initHeader(),
                MeItem("关于我们","","assets/images/me_aboutus.png"),
                MeItem("微信公众号","beirstory","assets/images/me_wechat.png"),
//                MeItem("分享app",appVersion,"assets/images/me_share.png"),
//                MeItem("给个好评","","assets/images/me_good.png"),
//                MeItem("隐私协议","","assets/images/me_yinsi.png"),
                MeItem("客服电话","02155039850","assets/images/me_phone.png"),

              ],
            ),
          ),
        ),
      ],
    );
  }


}