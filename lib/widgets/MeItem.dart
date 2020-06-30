import 'package:flutter/material.dart';

class MeItem extends StatelessWidget {

  var title = "";
  var info = "";

  var imgPath="";



  MeItem(this.title, this.info,this.imgPath);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return new Container(
      padding: const EdgeInsets.all(10.0),
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
    );


  }
}