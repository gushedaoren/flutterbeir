

import 'dart:convert';


import 'package:common_utils/common_utils.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:date_format/date_format.dart';
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

}