
import 'dart:async';
import 'dart:convert';


import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbeir/base/BaseStatefulWidget.dart';
import 'package:flutterbeir/config/BRColor.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/media/VideoPlayPage.dart';
import 'package:flutterbeir/models/ModelBanner.dart';
import 'package:flutterbeir/models/ModelVideoHomeAll.dart';
import 'package:flutterbeir/models/ModelVideoSeriesList.dart';
import 'package:flutterbeir/widgets/StoryListItem.dart';
import 'package:rxdart/rxdart.dart';

class SeriesStoryListPage extends BaseStatefulWidget {


  VideozSeries1 videozSeries1;


  SeriesStoryListPage(this.videozSeries1); //  @override


  @override
  State<BaseStatefulWidget> createState()=> SeriesStoryListPageState(videozSeries1);


}

class SeriesStoryListPageState extends State<SeriesStoryListPage>{

  VideozSeries1 videozSeries1;
  StreamController<ModelVideoSeriesList> _streamSeriesController=new BehaviorSubject();

  SeriesStoryListPageState(this.videozSeries1);
  static var seriesStoryList;
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

    return Container(
        color: BrColors.colorBgWhite,
        child:new Column(
          children: [

            new Container(

              child: new Image.network(videozSeries1.icon,fit:BoxFit.cover,width:720,height: 180,),
            ),



            new Expanded(
                child: initListBuilder()
            )
          ],
        )
    );
  }


  initListView(){

   return new ListView.separated(
      padding: const EdgeInsets.all(10.0),
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
            return initListView();

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


  buildListData(Video item) {

    if(item.icon==null){
        item.icon=videozSeries1.storyIcon;
    }

    return GestureDetector(
      child: new Container(
          child:  StoryListItem(item.name,item.icon),

      ),



      onTap: () => listItemTap(item),
    );



  }


  listItemTap(Video item){
    print("taped:"+item.name);

    Navigator.push(
      context,
      //创建一个路由
      new MaterialPageRoute(
          builder: (context) => VideoPlayerPage(item),
          //设置下一个界面的名字（就是设置别名）
//          settings: RouteSettings(
//              name: 'StoryPlayPage',
//              arguments: {"datas": data}
//
//          )
      ),
    );


  }

  
}