

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbeir/media/BRMusicPlayer.dart';
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
  bool isSongPage = true;

  AudioPlayer audioPlayer = new AudioPlayer();


  void initState() {
    // AudioPlayer.logEnabled = true;
    super.initState();
    print(data.media);
    setState(() {

    });
     playThisMusic();

    audioPlayer.onAudioPositionChanged.listen((p) async {
// p参数可以获取当前进度，也是可以调整的，比如p.inMilliseconds
    });
  }
  playThisMusic() async {
    int result = await audioPlayer.play(data.media);
    if (result == 1) {
      // success
      print('play success');
    } else {
      print('play failed');
    }
  }

  stopThisMusic() async{
    int result = await audioPlayer.pause();
    if (result == 1) {
      // success
      print('pause success');
    } else {
      print('pause failed');
    }
  }
  onNext() {
    print('next');
    setState(() {

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


    return Scaffold(
      appBar: AppBar(title: Text(data.name),),
      body: new Column(
        children:[
          _content(),
          BRMusicPlayer(
              songUrl:data.media,
              songname:data.name,

              onCompleted:this.onCompleted,
              onError:this.onError,
              onNext:this.onNext,
              onPrevious:this.onPrevious,
              volume:1.0
          )
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
              height: 0.8 * width,
              width: 0.8 * width,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 10, //                   <--- border width here
                ),
                image: new DecorationImage(
                  image: new NetworkImage(data.icon),
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