
import 'dart:async';

import 'package:banner_view/banner_view.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterbeir/base/BaseStatefulWidget.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/models/ModelBanner.dart';
import 'package:flutterbeir/models/ModelHomeAll.dart';
import 'package:flutterbeir/pages/story/StroyGridView.dart';
import 'package:flutterbeir/widgets/BRBannerView.dart';
import 'package:flutterbeir/widgets/HomeHeader.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
class PageStoryHome extends BaseStatefulWidget {

  @override
  State<StatefulWidget> createState()=> PageStoryHomeState();

}
class PageStoryHomeState extends State<PageStoryHome> {


  StreamController<ModelHomeAll> _streamHomeAllController;



  static var _homeAllData;


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
                    new HomeHeader(1,"今日推荐","今日听什么？快来这里看看"),
                    new StoryGridView(0, _homeAllData),
                    new HomeHeader(2,"重磅推荐","充实每一天，成长看得见"),
                    new StoryGridView(1, _homeAllData),
                    new HomeHeader(5,"猜你喜欢","知识就是这样炼成的"),
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

    getHomeAllRequest();

    _streamHomeAllController=StreamController<ModelHomeAll>();
  }

  @override
  void didUpdateWidget(PageStoryHome oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print("didUpdateWidget");
  }


  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _streamHomeAllController.close();

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

              child: BRBannerView(),
            ),


           new Container(
             child:initHomeAllBuilder(),

           )
          ],
        ),
    );
  }

}