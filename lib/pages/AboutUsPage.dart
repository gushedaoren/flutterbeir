


import 'package:flutter/material.dart';
import 'package:flutterbeir/models/ModelAppinfo.dart';
import 'package:flutterbeir/utils/CacheUtil.dart';

class AboutUsPage extends StatelessWidget{
  var appdesc="";
  CacheUtil cacheUtil=CacheUtil();


  setAppinfo(value){
    print(value);

    ModelAppinfo appinfo=value;

    print(appinfo);


    var datas=appinfo.data;



    for(int i=0;i<datas.length;i++){
      Datum data=datas[i];

      if(data.optionkey.contains("appdesc")){
        appdesc=data.optionValue;
        print(appdesc);
      }

    }

    setState(){};









  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    cacheUtil.getAppInfo().then((value) => setAppinfo(value));





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
                Text(appdesc)

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