


import 'package:flutterbeir/models/ModelAppinfo.dart';

class AppinfoPraseTool{

  ModelAppinfo appinfo;


  AppinfoPraseTool(this.appinfo);

  getAppInfoValue(key){

    var optionValue;



    var datas=appinfo.data;



    for(int i=0;i<datas!.length;i++){
      Datum data=datas[i];

      if(data.optionkey!.contains(key)){
        optionValue=data.optionValue;
        print(optionValue);
      }

    }

    return optionValue;


  }

}
