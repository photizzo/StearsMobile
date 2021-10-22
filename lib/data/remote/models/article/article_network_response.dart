class ArticleNetworkResponse {
  List<Data>? data;
  Meta? meta;

  ArticleNetworkResponse({
      this.data, 
      this.meta});

  ArticleNetworkResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    return map;
  }

}

class Meta {
  int? page;

  Meta({
      this.page});

  Meta.fromJson(dynamic json) {
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['page'] = page;
    return map;
  }

}

class Data {
  int? id;
  String? title;
  String? imageUrl;
  String? author;
  String? avatar;
  String? description;
  int? minRead;
  String? createdAt;
  String? updatedAt;

  Data({
      this.id, 
      this.title, 
      this.imageUrl, 
      this.author, 
      this.avatar, 
      this.description, 
      this.minRead, 
      this.createdAt, 
      this.updatedAt});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    author = json['author'];
    avatar = json['avatar'];
    description = json['description'];
    minRead = json['minRead'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['imageUrl'] = imageUrl;
    map['author'] = author;
    map['avatar'] = avatar;
    map['description'] = description;
    map['minRead'] = minRead;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}