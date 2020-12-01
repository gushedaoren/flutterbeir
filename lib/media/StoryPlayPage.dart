
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/media/BRMusicPlayer.dart';
import 'package:flutterbeir/models/ModelHomeAll.dart';
import 'package:flutterbeir/models/ModelSeries.dart';

class StoryPlayPage extends StatefulWidget{


  var data;

  List datas;
  ModelSeries series;

  // StoryPlayPage(this.datas,this.data);

  StoryPlayPage(this.datas,this.data);




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new StoryPlayPageState(datas,data);
  }

}

class StoryPlayPageState extends State<StoryPlayPage>{
  var data;
  List datas;
  StoryPlayPageState(this.datas,this.data);
  bool isSongPage = true;

  BRMusicPlayer brMusicPlayer;

  void initState() {
    // AudioPlayer.logEnabled = true;
    super.initState();
    print(data.media);
    setState(() {

    });

  }
  playThisMusic() async {

  }

  stopThisMusic() async{

  }
  onNext() {
    print('next');

    setState(() {
     brMusicPlayer= BRMusicPlayer(
          songUrl:data.media,
          songname:data.name,
          songlist: datas,


          onCompleted:this.onCompleted,
          onError:this.onError,
          onNext:this.onNext,
          onPrevious:this.onPrevious,
          volume:1.0
      );
    });
    print('next123');

  }
  onPrevious() {
    print('previous');
  }
  onError(err) {
    print('something is wrong');
  }
  onCompleted() {
    print('completed');



  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    brMusicPlayer=BRMusicPlayer(
        songUrl:data.media,
        songname:data.name,
        songlist: datas,


        onCompleted:this.onCompleted,
        onError:this.onError,
//        onNext:this.onNext,
//        onPrevious:this.onPrevious,
        volume:1.0
    );
    return Scaffold(
      appBar: AppBar(

          iconTheme: IconThemeData(
            color: Colors.white, //修改颜色
          ),
          title: Text(data.name,style: new TextStyle(

        fontSize: 18.0,
        color: Colors.white,
      ))),
      body: new Column(
        children:[
          _content(),
          brMusicPlayer
        ]

      ),
    );
  }


  Widget _content() {
    double width = MediaQuery.of(context).size.width;
    if( this.isSongPage == true) {
      return new GestureDetector(
          onTap: () => setState((){this.isSongPage = false;}),
          child: new Container(

            margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
            padding: EdgeInsets.all(20),
              height: 0.8 * width,
              width: 0.8 * width,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 10, //                   <--- border width here
                ),
                image: new DecorationImage(
                  image: new NetworkImage(data.icon!=null?data.icon:widget.series.storyIcon),
                  fit: BoxFit.cover,
                ),
              ),
              child: null
          )
      );
    } else {
      return new GestureDetector(
          onTap: () => setState((){this.isSongPage = true;}),
          child: new Container(
            height: 0.8 * width,
            width: 0.8 * width,
            decoration: new BoxDecoration(
                color: Colors.yellow
            ),
            child:new Text('datas',style: TextStyle(color:  Colors.white)),
          )
      );
    }
  }

}