import 'package:flutter/material.dart';

class MeItem extends StatelessWidget {

  var title = "";
  var info = "";

  var imgPath="";



  MeItem(this.title, this.info,this.imgPath);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return new Container(
      padding: const EdgeInsets.all(8.0),
      child:  Row(


          children:[
            new Image.asset(imgPath),

            new Text(title, style: new TextStyle(

              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),),
            new Text(info, style: new TextStyle(

              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),),
          ]

      ),
    );


  }
}