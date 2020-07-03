


import 'package:flutter/material.dart';
import 'package:flutterbeir/utils/CacheUtil.dart';

class AboutUsPage extends StatelessWidget{

  CacheUtil cacheUtil=CacheUtil();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var data= cacheUtil.getCache(CacheUtil.key_appinfo);


    print(data[0]);
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
                Text("test")

              ],
            ),
          ),
        ),
      ],
    );
  }

  initHeader(){
    return Container(


      child: Container(

        height: 180,

        child: Center(
            child:new Container(
                width: 90,
                height: 90,
                child:new Image.asset("assets/images/br_qrcode.jpg")
            )


        ),
      ),
    );
  }


}