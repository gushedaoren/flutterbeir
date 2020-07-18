
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  }



  Color primaryColor;

  Color getPrimaryColor(){
    return Theme.of(context).primaryColor;

  }




}