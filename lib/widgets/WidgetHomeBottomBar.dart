import 'package:flutter/material.dart';
// 引入四个文件

import '../pages/tabbars/PageStoryHome.dart';
import '../pages/tabbars/PageVideoHome.dart';
import '../pages/tabbars/PageAI.dart';
import '../pages/tabbars/PageMe.dart';

// 动态的Widget
class WidgetHomeBottomBar extends StatefulWidget {
  WidgetHomeBottomBar({Key key}) : super(key: key);

  _BottonWidgetState createState() => _BottonWidgetState();
}

class _BottonWidgetState extends State<WidgetHomeBottomBar> {

  // 设置定义颜色变量
  final _Color = Colors.lightBlue;
  // 设置初始化的索引
  int _currentIndex = 0;

  List<Widget> lists =  List();
  // 重写方法 把四个文件添加到lists里面
  @override
  void initState() {
    lists
      ..add(PageStoryHome())
      ..add(PageVideoHome())
      ..add(PageAI())
      ..add(PageMe());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 根据用户点击的索引显示不同的内容
      body: lists[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            // 设置图标,颜色和文字
            icon: Icon(
              Icons.home,
              color: _Color,
            ),
            title: Text('故事',style: TextStyle(color: _Color),),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.email,
              color: _Color,
            ),
            title: Text('动画',style: TextStyle(color: _Color),),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pages,
              color: _Color,
            ),
            title: Text('智能',style: TextStyle(color: _Color),),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.airplay,
              color: _Color,
            ),
            title: Text('我的',style: TextStyle(color: _Color),),
          ),
        ],

        // 点击哪个高亮
        currentIndex: _currentIndex,

        // 用户点击哪个把索引赋值给 _currentIndex
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}