

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:common_utils/common_utils.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/models/ModelBanner.dart';
import 'package:flutterbeir/utils/CacheUtil.dart';
import 'package:flutterbeir/utils/CommonUtils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';





class PageAI extends StatefulWidget {
  final String username;
  final String uuid;


  PageAI(this.username, this.uuid);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<PageAI> {
  ChatUser? user = ChatUser();
  StreamController<ModelBanner>? _streamController;
  List<ChatMessage>? messages = List.empty();
  @override
  void initState() {
    user!.name = widget.username;
    user!.uid = widget.uuid;
    super.initState();



    _streamController = StreamController<ModelBanner>();

  }

  void onSend(ChatMessage message) async{



    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data=prefs.getString(CacheUtil.key_userinfo);

    Map<String, dynamic> user = json.decode(data!);

    var usrJson=user["brdata"];

    usrJson=usrJson.toString().replaceAll("'", "\"");

    Map<String, dynamic> userReal = json.decode(usrJson);

    print(userReal["uid"]);

    var uid=userReal["uid"].toString();
    ChatMessage messageMe=ChatMessage(
        text: message.text,
        user: ChatUser(
          name: "我",
          uid: uid,

        ),
        createdAt: DateTime.now(),
        quickReplies: QuickReplies(
          values: <Reply>[


          ],
        )


    );

    messages?.add(messageMe);
    chatRequest(message.text, uid);

  }


  chatRequest(keyword,userid) async {

    var url_post= BRConfig.domian+"/brstory/talkingtoairobot/";
    FormData formData = new FormData.from({

      "keyword":keyword,
      "userid":userid,
      "sign":CommonUtils.getSign(),


    });
    LogUtil.e(url_post);
    var dio = new Dio();
    var response = await dio.get(url_post, data: formData);


    var responseStr=response.data;
    print(responseStr);
    var answer="";
    var status=response.data["status"];
    if(status==0){
      answer=response.data["brdata"][0]["name"];
    }else {
      answer=response.data["brdata"]["data"]["answer"];
      print(answer);
    }





    ChatMessage messageReboot= ChatMessage(

        text: answer,
        user: ChatUser(
          name: "贝儿机器人",
          uid: "000000",
          avatar: BRConfig.ROBOT_IMAGE_URL,
        ),
        createdAt: DateTime.now(),
        quickReplies: QuickReplies(
          values: <Reply>[


          ],
        )



    );
    
    messages!.add(messageReboot);

    setState(() {

    });










  }


  void uploadFile() async {
    // File result = await ImagePicker.pickImage(
    //   source: ImageSource.gallery,
    //   imageQuality: 80,
    //   maxHeight: 400,
    //   maxWidth: 400,
    // );
    //
    // if (result != null) {
    //   String id = Uuid().v4().toString();

//      final StorageReference storageRef =
//      FirebaseStorage.instance.ref().child("chat_images/$id.jpg");
//
//      StorageUploadTask uploadTask = storageRef.putFile(
//        result,
//        StorageMetadata(
//          contentType: 'image/jpg',
//        ),
//      );
//      StorageTaskSnapshot download = await uploadTask.onComplete;
//
//      String url = await download.ref.getDownloadURL();
//
//      ChatMessage message = ChatMessage(text: "", user: user, image: url);
//
//      var documentReference = Firestore.instance
//          .collection('messages')
//          .document(DateTime.now().millisecondsSinceEpoch.toString());
//
//      Firestore.instance.runTransaction((transaction) async {
//        await transaction.set(
//          documentReference,
//          message.toJson(),
//        );
//      });
    }





  ChatMessage message1= ChatMessage(

    text: "小朋友，你好，我是贝儿机器人。",
    user: ChatUser(
      name: "贝儿机器人",
      uid: "00000000",
      avatar: BRConfig.ROBOT_IMAGE_URL,
    ),
    createdAt: DateTime.now(),
    quickReplies: QuickReplies(
      values: <Reply>[



      ],
    )



  );


  ChatMessage message2= ChatMessage(
    text: "This is a quick reply example.",
    user: ChatUser(),
    createdAt: DateTime.now(),
    quickReplies: QuickReplies(
      values: <Reply>[


      ],
    )


  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("贝儿机器人"),
      ),
      body: StreamBuilder(
        stream: _streamController!.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            if(messages!.length==0){
              messages!.add(message1);
            }

          }

          print(messages);




            return DashChat(
              user: user!,
              textBeforeImage: false,

              messages: messages!,
              inputDecoration: InputDecoration(
                hintText: "在这里输入内容哦...",
                border: InputBorder.none,
              ),
              onSend: onSend,
              trailing: <Widget>[
//                IconButton(
//                  icon: Icon(Icons.photo),
//                  onPressed: uploadFile,
//                )
              ],
            );

        },
      ),
    );
  }
}