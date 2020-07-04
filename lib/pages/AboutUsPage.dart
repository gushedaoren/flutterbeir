


import 'package:flutter/material.dart';
import 'package:flutterbeir/models/ModelAppinfo.dart';
import 'package:flutterbeir/utils/AppinfoPraseTool.dart';
import 'package:flutterbeir/utils/CacheUtil.dart';

class AboutUsPage extends StatelessWidget{
  var appdesc="";
  CacheUtil cacheUtil=CacheUtil();


  getAppDesc(value){


    AppinfoPraseTool appinfoPraseTool=AppinfoPraseTool(value);

    return "   "+appinfoPraseTool.getAppInfoValue("appdesc");







  }


  getCacheData(){
//    cacheUtil.getAppInfo().then((value) => setAppinfo(value));
    return cacheUtil.getAppInfo();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return new Container(
      color: Colors.white,
      child:  Column(


        children: <Widget>[
          initHeader(),
          initText()
        ],
      ),
    );


  }


  initText(){

   return FutureBuilder<ModelAppinfo>(
      future: getCacheData(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // 请求已结束
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          }else{
            // 请求成功，显示数据
            return new Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: new Text(getAppDesc(snapshot.data), style: new TextStyle(


                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                decoration: TextDecoration.none
              ),) ,
            );


        

          }
        }else{
          // 请求未结束，显示loading
          return CircularProgressIndicator();
        }
      },);

  }


  initHeader(){
    return Container(


      child: Container(

        height: 240,

        child: Center(
            child:new Container(
                width: 120,
                height: 120,
                child:new Image.asset("assets/images/br_qrcode.jpg")
            )


        ),
      ),
    );
  }


}