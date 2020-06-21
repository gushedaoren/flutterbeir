
import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/models/ModelBanner.dart';
import 'package:flutterbeir/models/ModelHomeAll.dart';
import 'package:flutterbeir/pages/story/StroyGridView.dart';
import 'package:flutterbeir/widgets/HomeHeader.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
class PageStoryHome extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=> PageStoryHomeState();

}
class PageStoryHomeState extends State<PageStoryHome> {

  StreamController<ModelBanner> _streamBannerController;
  StreamController<ModelHomeAll> _streamHomeAllController;

  static var _bannersData;

  static var _homeAllData;
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

  getHomeAllRequest() async {

    var url_post=BRConfig.domian+"/brstory/homeall/";
    FormData formData = new FormData.from({

    });
    LogUtil.e(url_post);
    var dio = new Dio();
    var response = await dio.get(url_post, data: formData);


    var responseStr=response.data;
    print(responseStr);

    var data=ModelHomeAll.fromJson(responseStr);

    _homeAllData=data;




    _streamHomeAllController.add(data);
    _streamHomeAllController.close();



  }

  initBannerSwiper(){
    return new Swiper(

      containerWidth: 720,
      containerHeight: 360,
      itemHeight: 360,
      itemWidth: 720,


      itemBuilder: (BuildContext context,int index){
        return Text("test");

//        return new Image.network(_bannersData.results[index%_bannersData.results.length].media.toString(),fit: BoxFit.cover,width: 720,height: 360);
      },
      itemCount: _bannersData.results.length,
      pagination: new SwiperPagination(),
      control: new SwiperControl(),
    );

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


  initHomeAllBuilder(){
    return StreamBuilder<ModelHomeAll>(
      stream:_streamHomeAllController.stream,
      //initialData: ,// a Stream<int> or null
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        // 请求已结束
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          }else{
            return new Container(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    new HomeHeader("今日推荐","今日听什么？快来这里看看"),
                    new StoryGridView(0, _homeAllData),
                    new HomeHeader("重磅推荐","充实每一天，成长看得见"),
                    new StoryGridView(1, _homeAllData),
                    new HomeHeader("猜你喜欢","知识就是这样炼成的"),
                    new StoryGridView(2, _homeAllData),
                  ]

              ),

            );


          }
        }else{
          // 请求未结束，显示loading
          return
            Center(
                child: CircularProgressIndicator()
            );


        }



      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    getBannerRequest();
    getHomeAllRequest();
    _streamBannerController = StreamController<ModelBanner>();
    _streamHomeAllController=StreamController<ModelHomeAll>();
  }

  @override
  void didUpdateWidget(PageStoryHome oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print("didUpdateWidget");
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
             child:initHomeAllBuilder(),

           )
          ],
        ),
    );
  }

}