


import 'package:flutter/material.dart';
import 'package:flutterbeir/models/ModelAppinfo.dart';
import 'package:flutterbeir/utils/CacheUtil.dart';

class AboutUsPage extends StatelessWidget{
  var appdesc="";
  CacheUtil cacheUtil=CacheUtil();


  getAppDesc(value){
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

    return appdesc;









  }


  getCacheData(){
//    cacheUtil.getAppInfo().then((value) => setAppinfo(value));
    return cacheUtil.getAppInfo();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build







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
               FutureBuilder<ModelAppinfo>(
                future: getCacheData(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  // 请求已结束
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      // 请求失败，显示错误
                      return Text("Error: ${snapshot.error}");
                    }else{
                      // 请求成功，显示数据
                      return Text(getAppDesc(snapshot.data));
                    }
                  }else{
                    // 请求未结束，显示loading
                    return CircularProgressIndicator();
                  }
                },)

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