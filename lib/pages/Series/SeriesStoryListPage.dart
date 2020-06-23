
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
import 'package:flutterbeir/models/ModelVideoSeries.dart';
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
  StreamController<List<ModelVideoSeries>> _streamSeriesController;

  SeriesStoryListPageState(this.videozSeries1);
  List<dynamic> seriesStoryList=new List(0);
  getSeriesStoryList(var seriesid) async {
    var url_post=BRConfig.domian+"/brstory/videolist/";
    FormData formData = new FormData.from({

      "seriesid":seriesid
    });
    LogUtil.e(url_post);
    var dio = new Dio();
    var response = await dio.get(url_post, data: formData);



    print(response);
    var datas=response.data;

    print(datas.length);


    for(var m in datas){
      print(m);
      print(m.runtimeType);
      var json=jsonDecode(m.toString());

      ModelVideoSeries videoSeries= ModelVideoSeries.fromJson(json);
      seriesStoryList.add(videoSeries);
    }


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
      itemCount: seriesStoryList.length,

      itemBuilder: (context, item) {
        return buildListData(seriesStoryList[item]);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),


    );


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    _streamSeriesController = StreamController<List<ModelVideoSeries>>();
    getSeriesStoryList(videozSeries1.id);


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return initSeriesViews();
  }


  initListBuilder(){
    return StreamBuilder<List<ModelVideoSeries>>(
      stream:_streamSeriesController.stream,
      //initialData: ,// a Stream<int> or null
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


  buildListData(ModelVideoSeries item) {



    return new Image.network(videozSeries1.icon,fit: BoxFit.none,width: 360,height: 180);

  }
  
}