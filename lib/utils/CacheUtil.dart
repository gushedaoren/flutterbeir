

import 'dart:convert';

import 'package:flutterbeir/models/ModelAppinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheUtil{
  static String key_appinfo="key_appinfo";
  setCache(key,value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key,value);
  }

  getCache(key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future<ModelAppinfo> getAppInfo() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data=prefs.getString(key_appinfo);

    Map mMap = jsonDecode(data);

    var appinfo = ModelAppinfo.fromJson(mMap);



    return appinfo;
  }

}