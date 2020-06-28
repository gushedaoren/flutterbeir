

import 'dart:async';

import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutterbeir/config/BRConfig.dart';
import 'package:flutterbeir/models/ModelBanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';





class PageAI extends StatefulWidget {
  final String username;
  final String uuid;


  PageAI(this.username, this.uuid);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<PageAI> {
  ChatUser user = ChatUser();
  StreamController<ModelBanner> _streamController;
  @override
  void initState() {
    user.name = widget.username;
    user.uid = widget.uuid;
    super.initState();


    chatRequest();
    _streamController = StreamController<ModelBanner>();

  }

  void onSend(ChatMessage message) {
//    var documentReference = Firestore.instance
//        .collection('messages')
//        .document(DateTime.now().millisecondsSinceEpoch.toString());
//
//    Firestore.instance.runTransaction((transaction) async {
//      await transaction.set(
//        documentReference,
//        message.toJson(),
//      );
//    });
  }


  chatRequest() async {

    var url_post= BRConfig.domian+"/brstory/talkingtoairobot/";
    FormData formData = new FormData.from({

    });
    LogUtil.e(url_post);
    var dio = new Dio();
    var response = await dio.get(url_post, data: formData);


    var responseStr=response.data;
    print(responseStr);





  }


  void uploadFile() async {
    File result = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxHeight: 400,
      maxWidth: 400,
    );

    if (result != null) {
      String id = Uuid().v4().toString();

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
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            );
          } else {
            List<ChatMessage> messages = new List<ChatMessage>();
            messages.add(message1);
            messages.add(message2);

            return DashChat(
              user: user,
              messages: messages,
              inputDecoration: InputDecoration(
                hintText: "在这里输入内容哦...",
                border: InputBorder.none,
              ),
              onSend: onSend,
              trailing: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: uploadFile,
                )
              ],
            );
          }
        },
      ),
    );
  }
}