

import 'dart:convert';

import 'dart:io';


import 'package:common_utils/common_utils.dart';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutterbeir/config/BRConfig.dart';

import 'package:package_info/package_info.dart';
import 'package:uuid/uuid.dart';

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


    systemVersion=Platform.operatingSystemVersion.toString();
    platform=Platform.operatingSystem;

    if(Platform.isIOS){
      //ios相关代码
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceid=Uuid.NAMESPACE_DNS;
      model=iosInfo.model;

      systemVersion=iosInfo.systemVersion;



    }else if(Platform.isAndroid){
      //android相关代码

      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      deviceid=androidInfo.androidId;
      model=androidInfo.model;

      manufacturer=androidInfo.manufacturer;

    }

    print("设备id:"+deviceid);


    var url_post=BRConfig.domian+"/brstory/autoregister/";

    FormData formData = new FormData.from(
        {
          "deviceid":deviceid,
          "platform":platform,
          "model":model,
          "appversion":appversion,
          "buildNumber":buildNumber,
          "systemVersion":systemVersion,
          "manufacturer":manufacturer,

        }
    );
    try{
      Response response;
      var mdata={
        "deviceid":deviceid,
        "platform":platform,
        "model":model,
        "appversion":appversion,
        "buildNumber":buildNumber,
        "systemVersion":systemVersion,
        "manufacturer":manufacturer,

      };
      print(mdata);
      response = await Dio().post(
          url_post,
          data:formData
      );

      var responseStr=response.data;
      print(responseStr);



      String rawJson = jsonEncode(responseStr);


      cacheUtil.setCache(CacheUtil.key_userinfo,rawJson);
    }catch(e){
      return print(e);
    }







  }
}