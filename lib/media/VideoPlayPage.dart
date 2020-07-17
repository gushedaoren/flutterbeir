import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutterbeir/models/ModelVideoSeriesList.dart';
import 'package:video_player/video_player.dart';
class VideoPlayerPage extends StatefulWidget {
  Video item;


  VideoPlayerPage(this.item);

  _VideoPlayerPageState createState() => _VideoPlayerPageState(item);
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {

  Video item;

  VideoPlayerController _controller;
  _VideoPlayerPageState(this.item);

  @override
  void initState() {
    super.initState();
    //配置视频地址

    _controller = VideoPlayerController.network(
        item.media)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {

          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Center(
        //视频播放器
        child: _controller.value.initialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),


    );
  }

  @override
  void dispose() {

    super.dispose();
    _controller.dispose();
  }
}