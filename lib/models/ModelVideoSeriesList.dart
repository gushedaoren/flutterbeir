// To parse this JSON data, do
//
//     final modelVideoSeriesList = modelVideoSeriesListFromJson(jsonString);

import 'dart:convert';

List<ModelVideoSeriesList> modelVideoSeriesListFromJson(String str) => List<ModelVideoSeriesList>.from(json.decode(str).map((x) => ModelVideoSeriesList.fromJson(x)));

String modelVideoSeriesListToJson(List<ModelVideoSeriesList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelVideoSeriesList {
  ModelVideoSeriesList({
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
  dynamic icon;
  String media;
  dynamic views;
  int hot;
  dynamic price;
  int category;
  bool lock;

  factory ModelVideoSeriesList.fromJson(Map<String, dynamic> json) => ModelVideoSeriesList(
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
