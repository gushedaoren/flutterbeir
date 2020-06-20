

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbeir/models/ModelHomeAll.dart';

class StoryPlayPage extends StatefulWidget{


  Homegrid data;


  StoryPlayPage(this.data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new StoryPlayPageState(data);
  }

}

class StoryPlayPageState extends State<StoryPlayPage>{
  Homegrid data;
  StoryPlayPageState(this.data);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
      appBar: AppBar(title: Text(data.name),),
      body: Center(
        child: Text(data.media),
      ),
    );
  }

}