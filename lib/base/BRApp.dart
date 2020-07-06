

import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';
class BRApp{


  // 这样写就行了，别问为什么，我也不知道，慢慢理解
  static final BRApp _singleton = BRApp._internal();

  // Use the factory keyword when implementing a constructor that doesn’t always create a new instance of its class.
  // For example, a factory constructor might return an instance from a cache, or it might return an instance of a subtype.
  factory BRApp() => _singleton;

  BRApp._internal(); // private constructor



  BRApp app;
  BuildContext context;
  void init(BuildContext context){
    this.context=context;
    LogUtil.init();
    LogUtil.v("app initing");

    initUMeng();

  }


  void initUMeng() async{
    var result = await UmengAnalyticsPlugin.init(
      androidKey: '5b08c03b8f4a9d2f11000747',
      iosKey: '5f02bc7e895cca3b65000038',
    );
  }



  Color primaryColor;

  Color getPrimaryColor(){
    return Theme.of(context).primaryColor;

  }




}