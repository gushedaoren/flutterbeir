
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
import 'package:flutterbeir/models/ModelSeries.dart';
import 'package:flutterbeir/models/ModelStorys.dart';
import 'package:flutterbeir/models/ModelVideoHomeAll.dart';
import 'package:flutterbeir/models/ModelVideoSeriesList.dart';
import 'package:flutterbeir/widgets/MusicStoryListItem.dart';
import 'package:flutterbeir/widgets/StoryListItem.dart';
import 'package:rxdart/rxdart.dart';

class StoryListPage extends BaseStatefulWidget {


  var seriesid;

  String title;


  StoryListPage(this.seriesid,this.title); //  @override


  @override
  State<BaseStatefulWidget> createState()=> StoryListPageState(seriesid,title);


}

class StoryListPageState extends State<StoryListPage>{

  var seriesid;

  String? title;
  ModelSeries? series;
  StreamController<ModelStorys> _streamSeriesController=new BehaviorSubject();

  StoryListPageState(this.seriesid,this.title);
  static ModelStorys? seriesStoryList;
  getSeriesStoryList(var seriesid) async {
    var url_post=BRConfig.domian+"/brstory/storylist?seriesid="+seriesid.toString();



    LogUtil.e(url_post);
    var dio = new Dio();
    var response = await dio.get(url_post);



    seriesStoryList=ModelStorys.fromJson(response.data);



    _streamSeriesController.add(seriesStoryList!);
    _streamSeriesController.close();
  }



  initSeriesViews(){

    return Container(
        color: BrColors.colorBgWhite,
        child:new Column(
          children: [




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
      itemCount: seriesStoryList!.storys.length,

      itemBuilder: (context, item) {
        return buildListData(seriesStoryList!.storys,item);
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

    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(title!)),

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
      iconurl=series!.storyIcon;
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
    storyPlayPage!.series=series!;
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