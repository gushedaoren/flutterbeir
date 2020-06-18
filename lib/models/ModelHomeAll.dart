// To parse this JSON data, do
//
//     final modelHomeAll = modelHomeAllFromJson(jsonString);

import 'dart:convert';

ModelHomeAll modelHomeAllFromJson(String str) => ModelHomeAll.fromJson(json.decode(str));

String modelHomeAllToJson(ModelHomeAll data) => json.encode(data.toJson());

class ModelHomeAll {
  ModelHomeAll({
    this.homegrid1,
    this.homegrid2,
    this.homegrid3,
    this.zhuanti,
    this.huiben,
  });

  List<Homegrid> homegrid1;
  List<Homegrid> homegrid2;
  List<Homegrid> homegrid3;
  List<Zhuanti> zhuanti;
  List<Huiben> huiben;

  factory ModelHomeAll.fromJson(Map<String, dynamic> json) => ModelHomeAll(
    homegrid1: List<Homegrid>.from(json["homegrid1"].map((x) => Homegrid.fromJson(x))),
    homegrid2: List<Homegrid>.from(json["homegrid2"].map((x) => Homegrid.fromJson(x))),
    homegrid3: List<Homegrid>.from(json["homegrid3"].map((x) => Homegrid.fromJson(x))),
    zhuanti: List<Zhuanti>.from(json["zhuanti"].map((x) => Zhuanti.fromJson(x))),
    huiben: List<Huiben>.from(json["huiben"].map((x) => Huiben.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "homegrid1": List<dynamic>.from(homegrid1.map((x) => x.toJson())),
    "homegrid2": List<dynamic>.from(homegrid2.map((x) => x.toJson())),
    "homegrid3": List<dynamic>.from(homegrid3.map((x) => x.toJson())),
    "zhuanti": List<dynamic>.from(zhuanti.map((x) => x.toJson())),
    "huiben": List<dynamic>.from(huiben.map((x) => x.toJson())),
  };
}

class Homegrid {
  Homegrid({
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

  factory Homegrid.fromJson(Map<String, dynamic> json) => Homegrid(
    id: json["id"],
    name: json["name"],
    info: json["info"],
    icon: json["icon"],
    media: json["media"],
    views: json["views"] == null ? null : json["views"],
    hot: json["hot"] == null ? null : json["hot"],
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
    "views": views == null ? null : views,
    "hot": hot == null ? null : hot,
    "price": price,
    "category": category,
    "lock": lock,
  };
}

class Huiben {
  Huiben({
    this.id,
    this.title,
    this.url,
    this.desc,
    this.icon,
  });

  int id;
  String title;
  String url;
  String desc;
  String icon;

  factory Huiben.fromJson(Map<String, dynamic> json) => Huiben(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    desc: json["desc"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "desc": desc,
    "icon": icon,
  };
}

class Zhuanti {
  Zhuanti({
    this.id,
    this.title,
    this.info,
    this.icon,
    this.category,
    this.price,
    this.storyIcon,
  });

  int id;
  String title;
  String info;
  String icon;
  int category;
  String price;
  String storyIcon;

  factory Zhuanti.fromJson(Map<String, dynamic> json) => Zhuanti(
    id: json["id"],
    title: json["title"],
    info: json["info"],
    icon: json["icon"],
    category: json["category"],
    price: json["price"],
    storyIcon: json["storyIcon"] == null ? null : json["storyIcon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "info": info,
    "icon": icon,
    "category": category,
    "price": price,
    "storyIcon": storyIcon == null ? null : storyIcon,
  };
}
