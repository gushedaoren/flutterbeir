

import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BRApp{

  BRApp app;
  BuildContext context;
  void init(){
    LogUtil.init();
    LogUtil.v("app initing");
  }

  getInstance(BuildContext context){
    if(app==null){
      app=new BRApp(context);
    }
    return app;
  }


  BRApp(this.context);

  Color primaryColor;

  Color getPrimaryColor(){
    return Theme.of(context).primaryColor;

  }




}