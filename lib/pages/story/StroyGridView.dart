import 'package:flutter/material.dart';
import 'package:flutterbeir/base/BaseStatefulWidget.dart';
import 'package:flutterbeir/media/StoryPlayPage.dart';
import 'package:flutterbeir/models/ModelHomeAll.dart';

class StoryGridView extends StatelessWidget {

  //0 今日推荐 1 重磅推荐 2 猜你喜欢
  int type=0;

  ModelHomeAll homeAll;

  StoryGridView(this.type,this.homeAll);


  BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context=context;


    List gridDatas;

    int coloum=3;
    switch(type){
      case 0:
        gridDatas=homeAll.homegrid1;
        coloum=2;
        break;
      case 1:
        gridDatas=homeAll.homegrid2;
        coloum=3;
        break;
      case 2:
        gridDatas=homeAll.homegrid3;
        coloum=3;
        break;
      default:
        break;


    }

    return GridView.builder(
      shrinkWrap: true,
      itemCount: gridDatas.length,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 5),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: coloum,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 10/12,
      ),
      itemBuilder: (context, index) {
        return getItemContainer(gridDatas,index);
      },
    );
  }


  clickItem(List datas,var index){

    Homegrid data=datas[index];
    print(data);
    Navigator.push(
      context,
      //创建一个路由
      new MaterialPageRoute(
          builder: (context) => StoryPlayPage(datas,data),
          //设置下一个界面的名字（就是设置别名）
          settings: RouteSettings(
              name: 'StoryPlayPage',
              arguments: {"datas": data}

          )
      ),
    );

  }


  initGridItem(Homegrid data){
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Image(
          image: NetworkImage(data.icon),
        ),
        new Expanded(
          child: new Text(
            data.name,
            style: new TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  getItemContainer(List datas,var index){

    Homegrid data=datas[index];

    return new GestureDetector(
      onTap: () {
        //处理点击事件
        print("clicke grid item");

        clickItem(datas,index);
      },
      child: new Container(
        padding: const EdgeInsets.all(2.0),
        child: initGridItem(data)
      ),
    );



  }

}