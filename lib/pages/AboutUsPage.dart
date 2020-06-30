


import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CustomScrollView(
      shrinkWrap: false,

      // 内容
      slivers: <Widget>[
        new SliverPadding(
          padding: const EdgeInsets.all(0.0),
          sliver: new SliverList(
            delegate: new SliverChildListDelegate(
              <Widget>[
                initHeader(),

              ],
            ),
          ),
        ),
      ],
    );
  }

  initHeader(){
    return Container(


      child: Container(

        height: 180,

        child: Center(
            child:new Container(
                width: 90,
                height: 90,
                child:new Image.asset("assets/images/br_qrcode.jpg")
            )


        ),
      ),
    );
  }


}