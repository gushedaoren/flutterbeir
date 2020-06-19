import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children:[
          new Text('今日推荐'),
          new Text('今天听什么？快来这里看看'),
        ]

    );
  }
}