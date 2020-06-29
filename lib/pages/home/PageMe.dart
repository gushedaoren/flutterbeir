import 'package:flutter/material.dart';
import 'package:flutterbeir/widgets/MeItem.dart';

class PageMe extends StatelessWidget {

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
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: new NetworkImage(
              'https://randomuser.me/api/portraits/men/43.jpg'),
        ),
      ),
      child: Container(
        color: Colors.red.withOpacity(.5),
        child: Center(
          child: Text(
            "我在图片的上面哦~",
            style: TextStyle(color: Colors.white, fontSize: 33),
          ),
        ),
      ),
    );
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
                MeItem("分享app","3.0","assets/images/me_share.png"),
                MeItem("给个好评","","assets/images/me_good.png"),
                MeItem("隐私协议","","assets/images/me_yinsi.png"),
                MeItem("客服电话","02155039850","assets/images/me_phone.png"),

              ],
            ),
          ),
        ),
      ],
    );
  }

}