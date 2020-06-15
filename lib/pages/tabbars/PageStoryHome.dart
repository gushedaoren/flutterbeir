
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
class PageStoryHome extends StatelessWidget {

  static var _bannersData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('儿童故事'),),
      body: Center(
        child:
        new Center(child: new CircularProgressIndicator())

      ),
    );
  }


  @override
  StatelessElement createElement() {
    // TODO: implement createElement

    getBannerRequest();

    return super.createElement();
  }


  @override
  void initState() {

  }




  void getBannerRequest() async {

    var url_post="http://beir.1207game.com/brstory/banner/";
    FormData formData = new FormData.from({

    });
    LogUtil.e(url_post);
    var dio = new Dio();
    var response = await dio.get(url_post, data: formData);

    LogUtil.e(response.data.toString());
    var dataResult = jsonDecode(response.data.toString());



    _bannersData=dataResult['results'];

    LogUtil.e(_bannersData.toString());



  }

  var bannerSwiper=BannerSwiper(

    //width  和 height 是图片的高宽比  不用传具体的高宽   必传
    height: 108,
    width: 54,
    //轮播图数目 必传
    length: 2,

    //轮播的item  widget 必传
    getwidget: (index) {
      return new GestureDetector(
          child:  Image.network(_bannersData[index].media,fit: BoxFit.cover,),
          onTap: () {
            //点击后todo
          });
    },
  );
}

