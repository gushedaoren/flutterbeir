
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
import 'package:flutterbeir/models/ModelStorys.dart';
import 'package:flutterbeir/models/ModelVideoHomeAll.dart';
import 'package:flutterbeir/models/ModelVideoSeriesList.dart';
import 'package:flutterbeir/widgets/MusicStoryListItem.dart';
import 'package:flutterbeir/widgets/StoryListItem.dart';
import 'package:rxdart/rxdart.dart';

class SeriesMusicStoryListPage extends BaseStatefulWidget {


  String  seriesid;

  String seriesIcon;


  SeriesMusicStoryListPage(this.seriesid,this.seriesIcon); //  @override


  @override
  State<BaseStatefulWidget> createState()=> SeriesStoryListPageState(seriesid,seriesIcon);


}

class SeriesStoryListPageState extends State<SeriesMusicStoryListPage>{

  String seriesIcon;
  String seriesid;
  StreamController<ModelVideoSeriesList> _streamSeriesController=new BehaviorSubject();

  SeriesStoryListPageState(this.seriesid,this.seriesIcon);
  static var seriesStoryList;
  getSeriesStoryList(var seriesid) async {
    var url_post=BRConfig.domian+"/brstory/storylist/?seriesid="+seriesid;

    LogUtil.e(url_post);
    var dio = new Dio();
    var response = await dio.get(url_post);



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

              child: new Image.network(seriesIcon,fit:BoxFit.cover,width:720,height: 180,),
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

    getSeriesStoryList(seriesid);



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
        item.icon=seriesIcon;
    }

    return GestureDetector(
      child: new Container(
          child:  MusicStoryListItem(item.name,item.icon),

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