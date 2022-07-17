// To parse this JSON data, do
//
//     final modelSeries = modelSeriesFromJson(jsonString);

import 'dart:convert';

ModelSeries modelSeriesFromJson(String str) => ModelSeries.fromJson(json.decode(str));

String modelSeriesToJson(ModelSeries data) => json.encode(data.toJson());

class ModelSeries {
  ModelSeries({
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
  dynamic storyIcon;

  factory ModelSeries.fromJson(Map<String, dynamic> json) => ModelSeries(
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
