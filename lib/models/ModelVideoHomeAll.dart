// To parse this JSON data, do
//
//     final modelVideoHomeAll = modelVideoHomeAllFromJson(jsonString);

import 'dart:convert';

ModelVideoHomeAll modelVideoHomeAllFromJson(String str) => ModelVideoHomeAll.fromJson(json.decode(str));

String modelVideoHomeAllToJson(ModelVideoHomeAll data) => json.encode(data.toJson());

class ModelVideoHomeAll {
  ModelVideoHomeAll({
    this.videozSeries1,
  });

  List<VideozSeries1>? videozSeries1;

  factory ModelVideoHomeAll.fromJson(Map<String, dynamic> json) => ModelVideoHomeAll(
    videozSeries1: List<VideozSeries1>.from(json["videozSeries1"].map((x) => VideozSeries1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "videozSeries1": List<dynamic>.from(videozSeries1!.map((x) => x.toJson())),
  };
}

class VideozSeries1 {
  VideozSeries1({
    this.id,
    this.title,
    this.info,
    this.icon,
    this.category,
    this.price,
    this.storyIcon,
  });

  int? id;
  String? title;
  String? info;
  String? icon;
  int? category;
  String? price;
  String? storyIcon;

  factory VideozSeries1.fromJson(Map<String, dynamic> json) => VideozSeries1(
    id: json["id"],
    title: json["title"],
    info: json["info"],
    icon: json["icon"],
    category: json["category"],
    price: json["price"],
    storyIcon: json["storyIcon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "info": info,
    "icon": icon,
    "category": category,
    "price": price,
    "storyIcon": storyIcon,
  };
}
