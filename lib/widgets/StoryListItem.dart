import 'package:flutter/material.dart';

class StoryListItem extends StatelessWidget {

  var title = "";
  var info = "";


  StoryListItem(this.title, this.info);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return new Container(
      padding: const EdgeInsets.all(8.0),
      child:  Row(


          children:[

            new Text(title, style: new TextStyle(

              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: color,
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