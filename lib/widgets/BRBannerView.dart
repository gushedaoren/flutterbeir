import 'dart:async';
import 'dart:ui';


import 'package:banner_view/banner_view.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterbeir/base/BaseStatefulWidget.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/models/ModelBanner.dart';

import 'BannerImage.dart';

class BRBannerView extends BaseStatefulWidget {


  @override
  State<StatefulWidget> createState()=> BRBannerViewState();
}

class BRBannerViewState extends State<BRBannerView>{

  StreamController<ModelBanner> _streamBannerController;

  static var _bannersData;

  var bannerSwiper;

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
        child:new Image.asset(
        "assets/images/banner_music_default.jpg",
        width: window.physicalSize.width,
        height: 240.0,
        //类似于Android的scaleType 此处让图片尽可能小 以覆盖整个widget
        fit: BoxFit.cover,
    ));
//        child: new BannerView(
//            [
//              BannerImage(_bannersData.results[0]),
//              BannerImage(_bannersData.results[1]),
//            ]
//        ));



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
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();

    _streamBannerController.close();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return initBannerBuilder();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    getBannerRequest();

    _streamBannerController = StreamController<ModelBanner>();

  }

  
}

