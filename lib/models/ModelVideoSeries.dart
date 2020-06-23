
class ModelVideoSeries {
  int id;
  String name;
  String info;
  Null icon;
  String media;
  Null views;
  int hot;
  Null price;
  int category;
  bool lock;

  ModelVideoSeries(
      {this.id,
        this.name,
        this.info,
        this.icon,
        this.media,
        this.views,
        this.hot,
        this.price,
        this.category,
        this.lock});

  ModelVideoSeries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    info = json['info'];
    icon = json['icon'];
    media = json['media'];
    views = json['views'];
    hot = json['hot'];
    price = json['price'];
    category = json['category'];
    lock = json['lock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['info'] = this.info;
    data['icon'] = this.icon;
    data['media'] = this.media;
    data['views'] = this.views;
    data['hot'] = this.hot;
    data['price'] = this.price;
    data['category'] = this.category;
    data['lock'] = this.lock;
    return data;
  }
}

