// To parse this JSON data, do
//
//     final modelVideoSeriesList = modelVideoSeriesListFromJson(jsonString);

import 'dart:convert';

ModelVideoSeriesList modelVideoSeriesListFromJson(String str) => ModelVideoSeriesList.fromJson(json.decode(str));

String modelVideoSeriesListToJson(ModelVideoSeriesList data) => json.encode(data.toJson());

class ModelVideoSeriesList {
  ModelVideoSeriesList({
    this.videos,
  });

  List<Video>? videos;

  factory ModelVideoSeriesList.fromJson(Map<String, dynamic> json) => ModelVideoSeriesList(
    videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "videos": List<dynamic>.from(videos!.map((x) => x.toJson())),
  };
}

class Video {
  Video({
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

  int? id;
  String? name;
  String? info;
  dynamic icon;
  String? media;
  dynamic views;
  int? hot;
  dynamic price;
  int? category;
  bool? lock;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
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
