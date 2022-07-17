// To parse this JSON data, do
//
//     final modelBanner = modelBannerFromJson(jsonString);

import 'dart:convert';

ModelBanner modelBannerFromJson(String str) => ModelBanner.fromJson(json.decode(str));

String modelBannerToJson(ModelBanner data) => json.encode(data.toJson());

class ModelBanner {
    ModelBanner({
        this.next,
        this.previous,
        this.results,
    });

    dynamic next;
    dynamic previous;
    List<Result>? results;

    factory ModelBanner.fromJson(Map<String, dynamic> json) => ModelBanner(
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.bannerid,
        this.bannername,
        this.action,
        this.media,
        this.type,
        this.title,
        this.desc,
        this.article,
        this.actiontype,
        this.series,
        this.url,
    });

    int? bannerid;
    String? bannername;
    String? action;
    String? media;
    int? type;
    String? title;
    String? desc;
    dynamic article;
    int? actiontype;
    String? series;
    String? url;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        bannerid: json["bannerid"],
        bannername: json["bannername"],
        action: json["action"],
        media: json["media"],
        type: json["type"],
        title: json["title"],
        desc: json["desc"],
        article: json["article"],
        actiontype: json["actiontype"],
        series: json["series"] == null ? null : json["series"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "bannerid": bannerid,
        "bannername": bannername,
        "action": action,
        "media": media,
        "type": type,
        "title": title,
        "desc": desc,
        "article": article,
        "actiontype": actiontype,
        "series": series == null ? null : series,
        "url": url,
    };
}
