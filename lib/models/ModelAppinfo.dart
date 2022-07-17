// To parse this JSON data, do
//
//     final modelAppinfo = modelAppinfoFromJson(jsonString);

import 'dart:convert';

ModelAppinfo modelAppinfoFromJson(String str) => ModelAppinfo.fromJson(json.decode(str));

String modelAppinfoToJson(ModelAppinfo data) => json.encode(data.toJson());

class ModelAppinfo {
  ModelAppinfo({
    this.data,
  });

  List<Datum>? data;

  factory ModelAppinfo.fromJson(Map<String, dynamic> json) => ModelAppinfo(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.optionkey,
    this.desc,
    this.optionValue,
  });

  int? id;
  String? optionkey;
  String? desc;
  String? optionValue;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    optionkey: json["optionkey"],
    desc: json["desc"],
    optionValue: json["optionValue"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "optionkey": optionkey,
    "desc": desc,
    "optionValue": optionValue,
  };
}
