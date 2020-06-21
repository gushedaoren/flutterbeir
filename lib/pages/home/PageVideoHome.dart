import 'dart:async';


import 'package:banner_view/banner_view.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterbeir/base/BasePageState.dart';
import 'package:flutterbeir/base/BaseStatefulWidget.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/models/ModelBanner.dart';

class PageVideoHome extends BaseStatefulWidget {


//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('英语动画'),),
//      body: Center(
//        child: Text('动画'),
//      ),
//    );
//  }


  @override
  State<BaseStatefulWidget> createState()=> PageVideoHomeState();


}


class PageVideoHomeState extends State<PageVideoHome>{

  StreamController<ModelBanner> _streamBannerController;
  static var _bannersData;
  getBannerRequest() async {

    var url_post=BRConfig.domian+"/brstory/banner/";
    FormData formData = new FormData.from({

    });
    LogUtil.e(url_post);
    var dio = new Dio();
    var response = await dio.get(url_post, data: formData);


    var responseStr=response.data;
    print(responseStr);

    var data=ModelBanner.fromJson(responseStr);

    _bannersData= data;

    print(data.results[0].media.toString());


    _streamBannerController.add(_bannersData);
    _streamBannerController.close();



  }

  initBannerSwiper(){

    var bannerLength=_bannersData.results.length;
    return  Container(
        alignment: Alignment.center,
        height: 200.0,
        child: new BannerView(

            [
              new Image.network(_bannersData.results[0%bannerLength].media.toString(),fit: BoxFit.cover,width: 720,height: 360),
              new Image.network(_bannersData.results[1%bannerLength].media.toString(),fit: BoxFit.cover,width: 720,height: 360),
            ]
        ));

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    getBannerRequest();

    _streamBannerController = StreamController<ModelBanner>();

  }


  initBannerBuilder(){
    return StreamBuilder<ModelBanner>(
      stream:_streamBannerController.stream,
      //initialData: ,// a Stream<int> or null
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        // 请求已结束
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          }else{
            // 请求成功，显示数据
            return initBannerSwiper();

          }
        }else{
          // 请求未结束，显示loading
          return
            Center(

            );


        }



      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return  new SingleChildScrollView(

      //滑动的方向 Axis.vertical为垂直方向滑动，Axis.horizontal 为水平方向
      scrollDirection: Axis.vertical,
      //true 滑动到底部
      reverse: false,
      padding: EdgeInsets.all(0.0),
      ////滑动到底部回弹效果
      physics: BouncingScrollPhysics(),


      child: new Column(
        children: [

          new Container(

            child: initBannerBuilder(),
          ),


          new Container(
//            child:initHomeAllBuilder(),

          )
        ],
      ),
    );
  }



}
