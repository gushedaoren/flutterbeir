import 'package:flutter/material.dart';
import 'package:flutterbeir/models/ModelVideoHomeAll.dart';
import 'package:flutterbeir/pages/Series/SeriesMusicStoryListPage.dart';
import 'package:flutterbeir/pages/Series/StoryListPage.dart';

class HomeHeader extends StatelessWidget {

  var title = "";
  var info = "";

  int seriesid=0;

  BuildContext? context;
  HomeHeader(this.seriesid,this.title, this.info);





  onMoreClick(){
    Navigator.push(this.context!, MaterialPageRoute(builder: (context) {
      return StoryListPage(seriesid,title);
    }));

  }


  @override
  Widget build(BuildContext context) {
    this.context=context;
    Color color = Theme.of(context).primaryColor;

    return new Container(
      padding: const EdgeInsets.all(8.0),
      child:  Column(


          children:[

            new Text(title, style: new TextStyle(

              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),),

            new Row(

                children:[

                  Expanded(
                child: new Container(
                alignment: Alignment.center,

                  child:  new Text(info, style: new TextStyle(

                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),),
                )),



                  new  GestureDetector(

                    onTap: onMoreClick,
                    child: new Text("更多>>", style: new TextStyle(

                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: color,
                    )) ,
                  )
                 ]


            )

          ]

      ),
    );


  }
}