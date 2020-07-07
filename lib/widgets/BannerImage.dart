import 'package:flutter/material.dart';
import 'package:flutterbeir/models/ModelBanner.dart';


class BannerImage extends StatelessWidget {



  Result result;


  BannerImage(this.result);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return new Container(

      child:  Column(


          children:[

            new Image.network(result.media.toString(),fit: BoxFit.cover,width: 400,height: 200,)
          ]

      ),
    );


  }
}