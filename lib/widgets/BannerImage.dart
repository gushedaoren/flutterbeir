import 'package:flutter/material.dart';
import 'package:flutterbeir/models/ModelBanner.dart';
import 'package:flutterbeir/pages/Series/SeriesMusicStoryListPage.dart';


class BannerImage extends StatelessWidget {

  BuildContext context;
  _onClick(){


    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SeriesMusicStoryListPage(result.series,result.media);
    }));

  }

  Result result;


  BannerImage(this.result);

  @override
  Widget build(BuildContext context) {
    this.context=context;
    Color color = Theme.of(context).primaryColor;

    return
      new  GestureDetector(


            onTap: _onClick,


            child:  Column(


                children:[


                  new Image.network(result.media.toString(),fit: BoxFit.cover,width: 400,height: 200,)
                ]

            ),
          );



    }



}