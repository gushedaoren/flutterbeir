import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


// import '../song.dart';
class BRMusicPlayer extends StatefulWidget{
  // final String audioUrl;

  /// 音量
  final double volume;

  /// 错误回调
  final Function(String) onError;

  ///播放完成
  final Function() onCompleted;

  /// 上一首
  final Function() onPrevious;

  ///下一首
  final Function() onNext;

  final Function(bool) onPlaying;

  final String songUrl;
  final String songname;


  BRMusicPlayer({
    this.songUrl,
    this.songname,

    this.onCompleted,
    this.onError,
    this.onNext,
    this.onPrevious,
    this.volume,
    this.onPlaying,
  });
  @override
  // _PlayerState createState() => new _PlayerState();
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _PlayerState();
  }
}

class _PlayerState extends State<BRMusicPlayer> {
  AudioPlayer audioPlayer = new AudioPlayer();
  bool isPlaying = true;
  Duration duration;
  Duration position;
  double sliderValue;

  AudioPlayerState palyerState;
  dynamic listener1,listener2,listener3;
  stopThisMusic() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.resume();
    }
  }

  String _formatDuration(Duration d) {
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    print(d.inMinutes.toString() + "======" + d.inSeconds.toString());
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }
  playThisMusic() {
    audioPlayer.play(
        widget.songUrl
    );
  }

  initState() {
    super.initState();
    playThisMusic();

    listener1 = audioPlayer.onDurationChanged.listen((Duration d) {
      // print('Max duration: $d');
      setState(() => duration = d);
      if (position != null) {
        this.sliderValue = (position.inSeconds / duration.inSeconds);
      }
    });
    listener2 = audioPlayer.onAudioPositionChanged.listen((Duration  p){
      // print("Current position: $p");
      setState(() => position = p);


      if (duration != null) {
        this.sliderValue = (position.inSeconds / duration.inSeconds);
      }
    });
    listener3 = audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s){
      // print("Current player state: $s");
      if (s.toString().split('.')[1] == 'PLAYING') {
        setState(() {
          isPlaying = true;
        });
        return;
      }
      if (s.toString().split('.')[1] == 'PAUSED' || s.toString().split('.')[1] == 'COMPLETED') {
        setState(() {
          isPlaying = false;
        });
        return;
      }
    });
  }


  void deactivate() {
    audioPlayer.stop();
    super.deactivate();
  }

  @override
  void  dispose() {
    listener1.cancel();
    listener2.cancel();
    listener3.cancel();
    audioPlayer.release();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisAlignment: MainAxisAlignment.end,
      // children: _controllers(context),
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.yellow,
              onPressed: () => {widget.onPrevious()},
            ),
            this.isPlaying ?
            new IconButton(
              icon: Icon(Icons.stop),
              color: Colors.yellow,
              onPressed: () {
                stopThisMusic();
              },
            )
                :
            new IconButton(
              icon: Icon(Icons.play_arrow),
              color: Colors.yellow,
              onPressed: () {
                stopThisMusic();
              },
            ),
            new IconButton(
              icon: Icon(Icons.arrow_forward),
              color: Colors.yellow,
              onPressed: () => {
                // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context,) => new SongPage(widget.songUrl, widget.songname, widget.list))),
                widget.onNext()
              },
            ),
          ],),
        new Slider(
          onChanged: (newValue) {
            if (duration != null) {
              int seconds = (duration.inSeconds * newValue).round();
              print("audioPlayer.seek: $seconds");
              audioPlayer.seek(new Duration(seconds: seconds));
            }
          },
          value: sliderValue ?? 0.0,
          activeColor: Colors.yellow,
        ),
      ],
    );
  }
}