
import 'dart:async';
import 'dart:convert';


import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbeir/base/BaseStatefulWidget.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/models/ModelBanner.dart';
import 'package:flutterbeir/models/ModelVideoHomeAll.dart';
import 'package:flutterbeir/models/ModelVideoSeriesList.dart';
import 'package:flutterbeir/widgets/StoryListItem.dart';

class SeriesStoryListPage extends BaseStatefulWidget {


  VideozSeries1 videozSeries1;


  SeriesStoryListPage(this.videozSeries1); //  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('英语动画'),),
//      body: Center(
//        child: Text('动画'),
//      ),
//    );
//  }


  @override
  State<BaseStatefulWidget> createState()=> SeriesStoryListPageState(videozSeries1);


}

class SeriesStoryListPageState extends State<SeriesStoryListPage>{

  VideozSeries1 videozSeries1;
  StreamController<ModelVideoSeriesList> _streamSeriesController;

  SeriesStoryListPageState(this.videozSeries1);
  ModelVideoSeriesList seriesStoryList;
  getSeriesStoryList(var seriesid) async {
    var url_post=BRConfig.domian+"/brstory/videolist/";
    FormData formData = new FormData.from({

      "seriesid":seriesid
    });
    LogUtil.e(url_post);
    var dio = new Dio();
    var response = await dio.get(url_post, data: formData);



    seriesStoryList=ModelVideoSeriesList.fromJson(response.data);



    _streamSeriesController.add(seriesStoryList);
    _streamSeriesController.close();
  }

  initSeriesViews(){
    return new Column(
      children: [

        new Container(

          child: new Image.network(videozSeries1.icon,fit: BoxFit.none,width: 360,height: 180),
        ),


        new Expanded(
         child: initListBuilder()
        )
      ],
    );
  }


  initListView(){
    new ListView.separated(
      itemCount: seriesStoryList.videos.length,

      itemBuilder: (context, item) {
        return buildListData(seriesStoryList.videos[item]);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),


    );


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");

    getSeriesStoryList(videozSeries1.id);
    _streamSeriesController = StreamController<ModelVideoSeriesList>();


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return initSeriesViews();
  }


  initListBuilder(){
    return StreamBuilder<ModelVideoSeriesList>(
      stream:_streamSeriesController.stream,

      builder: (BuildContext context, AsyncSnapshot snapshot) {

        // 请求已结束
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          }else{
            // 请求成功，显示数据
            return initListBuilder();

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


  buildListData(Video item) {



    return new Image.network(videozSeries1.icon,fit: BoxFit.none,width: 360,height: 180);

  }
  
}