// To parse this JSON data, do
//
//     final modelRegisterResult = modelRegisterResultFromJson(jsonString);

import 'dart:convert';

ModelRegisterResult modelRegisterResultFromJson(String str) => ModelRegisterResult.fromJson(json.decode(str));

String modelRegisterResultToJson(ModelRegisterResult data) => json.encode(data.toJson());

class ModelRegisterResult {
  ModelRegisterResult({
    this.status,
    this.msg,
    this.brdata,
  });

  String status;
  String msg;
  String brdata;

  factory ModelRegisterResult.fromJson(Map<String, dynamic> json) => ModelRegisterResult(
    status: json["status"],
    msg: json["msg"],
    brdata: json["brdata"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "brdata": brdata,
  };
}
