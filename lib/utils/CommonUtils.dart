

import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:date_format/date_format.dart';
import 'package:package_info/package_info.dart';

class CommonUtils {


  static String getSign(){


    var datestr=formatDate(DateTime.now(), [yyyy, "", mm, "", dd]);

    String sign=datestr.toString()+"brstory";


    print("sign:"+sign);

    sign=generateMd5(sign);



    sign= sign.toUpperCase();
    print("sign md5:"+sign);

    return sign;
  }

  // md5 加密
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }


  getPackageInfo()   {
    PackageInfo mpackageInfo;
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      mpackageInfo=packageInfo;
    });

    return mpackageInfo;



  }

}
