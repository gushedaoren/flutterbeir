
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:flutterbeir/models/ModelBanner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
class PageStoryHome extends StatefulWidget {

  static ModelBanner _bannersData;

  PageStoryHomeState mState=PageStoryHomeState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('儿童故事'),),
      body: Center(
        child:
//        (_bannersData==null)?
        new Center(child: new CircularProgressIndicator())

      ),
    );
  }





  @override
  State<StatefulWidget> createState()=> PageStoryHomeState();

}
class PageStoryHomeState extends State<PageStoryHome> {



  static var _bannersData;
  var bannerSwiper=BannerSwiper(

    //width  和 height 是图片的高宽比  不用传具体的高宽   必传
    height: 108,
    width: 54,
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




  @override
  Widget build(BuildContext context) {

    void getBannerRequest() async {

      var url_post="http://beir.1207game.com/brstory/banner/";
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




    }

    getBannerRequest();

    return Container(
        child: bannerSwiper
    );
  }

}