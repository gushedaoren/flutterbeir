


import 'package:flutter/material.dart';
import 'package:flutterbeir/models/ModelAppinfo.dart';
import 'package:flutterbeir/utils/AppinfoPraseTool.dart';
import 'package:flutterbeir/utils/CacheUtil.dart';

class AboutUsPage extends StatelessWidget{
  var appdesc="   贝儿故事为家长和宝宝提供精心甄选的适合0—12岁婴幼儿听的故事，提倡由孩子父母用自己的声音真实的讲给孩子听，帮助爸爸妈妈们解决因工作繁忙而在孩子成长中缺失的困扰，倡导做有爱的父母，讲温度的故事给宝宝听。内容丰富涵盖了儿童故事、睡前故事、有声故事、儿歌、绘本故事、儿童读物、讲故事、绘本、漫画、胎教、三字经、兔小贝儿歌、卡通动画片、亲子游戏、小伴龙、安徒生童话、格林童话、幼儿园童谣、胎教故事、胎教音乐等";

  CacheUtil cacheUtil=CacheUtil();


  getAppDesc(value){


//    AppinfoPraseTool appinfoPraseTool=AppinfoPraseTool(value);
//
//    return "   "+appinfoPraseTool.getAppInfoValue("appdesc");

    return "贝儿故事为家长和宝宝提供精心甄选的适合0—12岁婴幼儿听的故事，提倡由孩子父母用自己的声音真实的讲给孩子听，帮助爸爸妈妈们解决因工作繁忙而在孩子成长中缺失的困扰，倡导做有爱的父母，讲温度的故事给宝宝听。内容丰富涵盖了儿童故事、睡前故事、有声故事、儿歌、绘本故事、儿童读物、讲故事、绘本、漫画、胎教、三字经、兔小贝儿歌、卡通动画片、亲子游戏、小伴龙、安徒生童话、格林童话、幼儿园童谣、胎教故事、胎教音乐等";





  }


  getCacheData(){
//    cacheUtil.getAppInfo().then((value) => setAppinfo(value));
    return cacheUtil.getAppInfo();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text("关于我们")),
      body: Center(
        //视频播放器
        child: new Container(
          padding: const EdgeInsets.all(10.0),
          color: Colors.white,
          child:  Column(



            children: <Widget>[

              initHeader(),
              new Text(appdesc, style: new TextStyle(



                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  decoration: TextDecoration.none
              ),)
            ],
          ),
        )

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

        height: 180,

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