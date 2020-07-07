// To parse this JSON data, do
//
//     final modelStorys = modelStorysFromJson(jsonString);

import 'dart:convert';

ModelStorys modelStorysFromJson(String str) => ModelStorys.fromJson(json.decode(str));

String modelStorysToJson(ModelStorys data) => json.encode(data.toJson());

class ModelStorys {
  ModelStorys({
    this.storys,
  });

  List<Story> storys;

  factory ModelStorys.fromJson(Map<String, dynamic> json) => ModelStorys(
    storys: List<Story>.from(json["storys"].map((x) => Story.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "storys": List<dynamic>.from(storys.map((x) => x.toJson())),
  };
}

class Story {
  Story({
    this.id,
    this.name,
    this.info,
    this.icon,
    this.media,
    this.views,
    this.hot,
    this.price,
    this.category,
    this.lock,
  });

  int id;
  String name;
  String info;
  String icon;
  String media;
  int views;
  int hot;
  String price;
  int category;
  bool lock;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    name: json["name"],
    info: json["info"],
    icon: json["icon"],
    media: json["media"],
    views: json["views"],
    hot: json["hot"],
    price: json["price"],
    category: json["category"],
    lock: json["lock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "info": info,
    "icon": icon,
    "media": media,
    "views": views,
    "hot": hot,
    "price": price,
    "category": category,
    "lock": lock,
  };
}
