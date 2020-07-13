import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutterbeir/models/ModelVideoSeriesList.dart';
import 'package:awsome_video_player/awsome_video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  Video item;


  VideoPlayerPage(this.item);

  _VideoPlayerPageState createState() => _VideoPlayerPageState(item);
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {

  Video item;


  _VideoPlayerPageState(this.item);

  @override
  void initState() {
    super.initState();
    //配置视频地址


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Center(
        //视频播放器
        child: AwsomeVideoPlayer(
          item.media,
          /// 视频播放配置
          playOptions: VideoPlayOptions(
              seekSeconds: 30,
              aspectRatio: 16 / 9,
              loop: true,
              autoplay: true,
              allowScrubbing: true,
              startPosition: Duration(seconds: 0)),
          /// 自定义视频样式
          videoStyle: VideoStyle(
            /// 自定义底部控制栏
            videoControlBarStyle: VideoControlBarStyle(
              /// 自定义颜色
              barBackgroundColor: Colors.blue,//控制栏的背景颜色

              /// 自定义进度条样式
              progressStyle: VideoProgressStyle(
                // padding: EdgeInsets.all(0),
                  playedColor: Colors.red,
                  bufferedColor: Colors.yellow,
                  backgroundColor: Colors.green,
                  dragBarColor: Colors.white,//进度条为`progress`时有效，如果时`basic-progress`则无效
                  height: 4,
                  progressRadius: 2,//进度条为`progress`时有效，如果时`basic-progress`则无效
                  dragHeight: 5//进度条为`progress`时有效，如果时`basic-progress`则无效
              ),
            ),
          ),
        ),

      ),
    );
  }

  @override
  void dispose() {

    super.dispose();
  }
}