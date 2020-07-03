

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
}