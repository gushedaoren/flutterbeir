
import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/models/ModelBanner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
class PageStoryHome extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=> PageStoryHomeState();

}
class PageStoryHomeState extends State<PageStoryHome> {

  StreamController<ModelBanner> _streamController;

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


    _streamController.add(_bannersData);
    _streamController.close();

    bannerSwiper=BannerSwiper(

      //width  和 height 是图片的高宽比  不用传具体的高宽   必传s
      height: 720,
      width: 360,
      //轮播图数目 必传
      length: (_bannersData==null)?0:_bannersData.results.length,

      //轮播的item  widget 必传
      getwidget: (index) {
        return new GestureDetector(
            child:  Image.network(_bannersData.results[index%_bannersData.results.length].media.toString(),fit: BoxFit.cover,),
            onTap: () {
              //点击后todo
            });
      },

    );



    return 0;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    getBannerRequest();
    _streamController = StreamController<ModelBanner>();
  }

  @override
  void didUpdateWidget(PageStoryHome oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print("didUpdateWidget");
  }


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<ModelBanner>(
      stream:_streamController.stream,
      //initialData: ,// a Stream<int> or null
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        // 请求已结束
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          }else{
            // 请求成功，显示数据
            return BannerSwiper(


              //width  和 height 是图片的高宽比  不用传具体的高宽   必传s
              height: 720,
              width: 360,
              //轮播图数目 必传
              length: (_bannersData==null)?0:_bannersData.results.length,

              //轮播的item  widget 必传
              getwidget: (index) {
                return new GestureDetector(
                    child:  Image.network(_bannersData.results[index%_bannersData.results.length].media.toString(),fit: BoxFit.cover,),
                    onTap: () {
                      //点击后todo
                    });
              },

            );
          }
        }else{
          // 请求未结束，显示loading
          return CircularProgressIndicator();
        }



      },
    );
  }

}