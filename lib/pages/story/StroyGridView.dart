import 'package:flutter/material.dart';
import 'package:flutterbeir/base/BaseStatelessWidget.dart';
import 'package:flutterbeir/models/ModelHomeAll.dart';

class StoryGridView extends StatelessWidget {

  //0 今日推荐 1 重磅推荐 2 猜你喜欢
  int type=0;

  ModelHomeAll homeAll;

  StoryGridView(this.type,this.homeAll);

  @override
  Widget build(BuildContext context) {


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
      padding: EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: coloum,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return getItemContainer(gridDatas[index]);
      },
    );
  }


  getItemContainer(Homegrid data){


    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Image(
          image: NetworkImage(data.icon),
        ),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
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

}