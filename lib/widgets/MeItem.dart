import 'package:flutter/material.dart';
import 'package:flutterbeir/pages/AboutUsPage.dart';
import 'package:flutterbeir/utils/Mydialog.dart';
import 'package:flutterbeir/utils/RequestUtil.dart';

class MeItem extends StatelessWidget {

  var title = "";
  var info = "";

  var imgPath="";


  BuildContext context;
  RequestUtil requestUtil=RequestUtil();

  MeItem(this.title, this.info,this.imgPath);

  _onClick(){


    print("点击了"+title);

    if(title.contains("关于我们")){

      requestUtil.autoRegister();
//      Navigator.push(context, MaterialPageRoute(builder: (context) {
//        return AboutUsPage();
//      }));
    }

    if(title.contains("隐私协议")){
      Mydialog mydialog=Mydialog(context);



      mydialog.showAlert("隐私协议");
    }


  }


  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    this.context=context;

    return new Container(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: _onClick,//写入方法名称就可以了，但是是无参的


      child:  Row(

          mainAxisAlignment:MainAxisAlignment.spaceBetween,

          children:[


            new Container(

              child: new Row(


                children: <Widget>[
                  new Container(
                    width: 30,
                    height: 30,
                    color: Colors.transparent,
                    child: new Image.asset(imgPath),
                  ),

                  new Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: new Text(title, style: new TextStyle(


                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),) ,
                  )


                ],
              ),
            ),
            new Text(info, style: new TextStyle(

              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),),


          ]

      ),
      ),
    );



  }
}