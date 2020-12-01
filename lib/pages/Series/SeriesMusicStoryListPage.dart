
import 'dart:async';
import 'dart:convert';


import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbeir/base/BaseStatefulWidget.dart';
import 'package:flutterbeir/config/BRColor.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/media/StoryPlayPage.dart';
import 'package:flutterbeir/media/VideoPlayPage.dart';
import 'package:flutterbeir/models/ModelBanner.dart';
import 'package:flutterbeir/models/ModelHomeAll.dart';
import 'package:flutterbeir/models/ModelSeries.dart';
import 'package:flutterbeir/models/ModelStorys.dart';
import 'package:flutterbeir/models/ModelVideoHomeAll.dart';
import 'package:flutterbeir/models/ModelVideoSeriesList.dart';
import 'package:flutterbeir/widgets/MusicStoryListItem.dart';
import 'package:flutterbeir/widgets/StoryListItem.dart';
import 'package:rxdart/rxdart.dart';

class SeriesMusicStoryListPage extends BaseStatefulWidget {


  String  seriresUrl;

  String seriesIcon;


  SeriesMusicStoryListPage(this.seriresUrl,this.seriesIcon); //  @override


  @override
  State<BaseStatefulWidget> createState()=> SeriesStoryListPageState(seriresUrl,seriesIcon);


}

class SeriesStoryListPageState extends State<SeriesMusicStoryListPage>{

  String seriesIcon;
  String seriresUrl;
  ModelSeries series;
  StreamController<ModelStorys> _streamSeriesController=new BehaviorSubject();

  SeriesStoryListPageState(this.seriresUrl,this.seriesIcon);
  static ModelStorys seriesStoryList;
  getSeriesStoryList(var seriesid) async {
    var url_post=BRConfig.domian+"/brstory/storylist?seriesid="+seriesid;
    FormData formData = new FormData.from({
      seriesid:seriesid
    });
    LogUtil.e(url_post);
    var dio = new Dio();
    var response = await dio.get(url_post,data: formData);



    seriesStoryList=ModelStorys.fromJson(response.data);



    _streamSeriesController.add(seriesStoryList);
    _streamSeriesController.close();
  }

  getSeriesID() async {

    var dio = new Dio();
    print(seriresUrl);
    var response = await dio.get(seriresUrl);



    series=ModelSeries.fromJson(response.data);

    print("seriresid:"+series.id.toString());
    getSeriesStoryList(series.id.toString());
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
      itemCount: seriesStoryList.storys.length,

      itemBuilder: (context, item) {
        return buildListData(seriesStoryList.storys,item);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),


    );


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");

    getSeriesID();





  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.dark,
          title: Text("")),
      body: Center(
        //视频播放器
        child: initSeriesViews(),

      ),
    );


  }


  initListBuilder(){
    return StreamBuilder<ModelStorys>(
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


  buildListData(var storys,int index) {


    Story item=storys[index];

    var iconurl=item.icon;

    if(iconurl==null){
      iconurl=series.storyIcon;
    }

    return GestureDetector(
      child: new Container(
          child:  MusicStoryListItem(item.name,iconurl),

      ),



      onTap: () => clickItem(storys,index),
    );



  }

  clickItem(List datas,var index){

    Story data=datas[index];
    print(data);
    StoryPlayPage storyPlayPage=StoryPlayPage(datas,data);
    storyPlayPage.series=series;

    Navigator.push(
      context,
      //创建一个路由
      new MaterialPageRoute(
          builder: (context) => storyPlayPage,
          //设置下一个界面的名字（就是设置别名）
          settings: RouteSettings(
              name: 'StoryPlayPage',
              arguments: {"datas": data}

          )
      ),
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