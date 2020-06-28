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
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  Video item;


  _VideoPlayerPageState(this.item);

  @override
  void initState() {
    super.initState();
    //配置视频地址
    videoPlayerController = VideoPlayerController.network(
        item.media);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2, //宽高比
      autoPlay: true, //自动播放
      looping: true, //循环播放
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Center(
        //视频播放器
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    /**
     * 当页面销毁的时候，将视频播放器也销毁
     * 否则，当页面销毁后会继续播放视频！
     */
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}