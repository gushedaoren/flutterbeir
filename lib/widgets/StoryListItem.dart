import 'package:flutter/material.dart';

class StoryListItem extends StatelessWidget {

  var title = "";
  var icon = "";


  StoryListItem(this.title, this.icon);

  initText(BuildContext context){
    Color color = Theme.of(context).primaryColor;
    return new Text(title, style: new TextStyle(

      decoration: TextDecoration.none,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),);

  }

  @override
  Widget build(BuildContext context) {


    return new Container(
      padding: const EdgeInsets.all(8.0),
      child:  Row(


          children:[


            new Image.network(icon,fit: BoxFit.fitWidth,width: 100,height: 100,),


            new Expanded(child: new Container(
                margin: const EdgeInsets.all(5.0),
                child: initText(context)))


          ]

      ),
    );


  }
}