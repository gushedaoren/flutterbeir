
import 'dart:async';
import 'dart:convert';


import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
  StreamController<List<ModelVideoSeriesList>> _streamSeriesController;

  SeriesStoryListPageState(this.videozSeries1);
  List<ModelVideoSeriesList> seriesStoryList;
  getSeriesStoryList(var seriesid) async {
    var url_post=BRConfig.domian+"/brstory/videolist/";
    FormData formData = new FormData.from({

      "seriesid":seriesid
    });
    LogUtil.e(url_post);
    var dio = new Dio();
    var response = await dio.get(url_post, data: formData);


    var responseStr=response.data;
    print(responseStr);

    seriesStoryList=json.decode(responseStr);

    print(seriesStoryList);


    _streamSeriesController.add(seriesStoryList);
    _streamSeriesController.close();
  }

  initSeriesViews(){
    return new Column(
      children: [

        new Container(

          child: new Image.network(videozSeries1.icon,fit: BoxFit.none,width: 360,height: 180),
        ),


        new Container(

         child: new ListView.separated(
              itemBuilder: (context, item) {
                return buildListData(seriesStoryList);
              },
//              separatorBuilder: (BuildContext context, int index) => new Divider(),  // 分割线
              itemCount: 3
          )
        )
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");

    getSeriesStoryList(videozSeries1.id);
    _streamSeriesController = StreamController<List<ModelVideoSeriesList>>();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return initSeriesViews();
  }

  buildListData(List<ModelVideoSeriesList> seriesStoryList) {

    print(seriesStoryList);

    return new StoryListItem("test", "info");

  }
  
}