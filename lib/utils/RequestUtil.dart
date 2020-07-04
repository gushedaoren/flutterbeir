

import 'dart:convert';
import 'dart:io';


import 'package:common_utils/common_utils.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:date_format/date_format.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/models/ModelAppinfo.dart';

import 'CacheUtil.dart';

class RequestUtil {
  CacheUtil cacheUtil=CacheUtil();
  getAppinfoRequest() async {

    var url_post=BRConfig.domian+"/brstory/appinfo/";
    FormData formData = new FormData.from({

    });
    LogUtil.e(url_post);
    var dio = new Dio();
    var response = await dio.get(url_post, data: formData);


    var responseStr=response.data;
    print(responseStr);

    String rawJson = jsonEncode(responseStr);


    cacheUtil.setCache(CacheUtil.key_appinfo,rawJson);




  }

  autoRegister() async{

    String deviceid;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if(Platform.isIOS){
      //ios相关代码
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceid=iosInfo.identifierForVendor;

    }else if(Platform.isAndroid){
      //android相关代码
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      deviceid=androidInfo.androidId;



    }

    print("设备id:"+deviceid);




  }
}