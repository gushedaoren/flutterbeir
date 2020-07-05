

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
import 'package:flutterbeir/models/ModelRegisterResult.dart';
import 'package:package_info/package_info.dart';

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

    String deviceid="";
    String model="";
    String appversion="";
    String buildNumber="";
    String platform="";
    String systemVersion="";
    String manufacturer="";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();


    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appversion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

    if(Platform.isIOS){
      //ios相关代码
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceid=iosInfo.identifierForVendor;
      model=iosInfo.model;
      platform="IOS";
      systemVersion=iosInfo.systemVersion;



    }else if(Platform.isAndroid){
      //android相关代码
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      deviceid=androidInfo.androidId;
      model=androidInfo.model;
      platform="Android";
      manufacturer=androidInfo.manufacturer;


    }

    print("设备id:"+deviceid);


    var url_post=BRConfig.domian+"/brstory/autoregister/";
    FormData formData = new FormData.from({
      "deviceid":deviceid,
      "platform":platform,
      "model":model,
      "appversion":appversion,
      "buildNumber":buildNumber,
      "systemVersion":systemVersion,
      "manufacturer":manufacturer,




    });
    LogUtil.e(url_post);
    print(formData);
    var dio = new Dio();
    var response = await dio.post(url_post, data: formData);
    print(response);


    var responseStr=response.data;
    print(responseStr);



    String rawJson = jsonEncode(responseStr);


    cacheUtil.setCache(CacheUtil.key_userinfo,rawJson);





  }
}