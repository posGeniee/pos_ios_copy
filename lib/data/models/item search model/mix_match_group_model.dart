// To parse this JSON data, do
//
//     final mixMatchGroupListModel = mixMatchGroupListModelFromMap(jsonString);

import 'dart:convert';

MixMatchGroupListModel mixMatchGroupListModelFromMap(String str) =>
    MixMatchGroupListModel.fromMap(json.decode(str));

String mixMatchGroupListModelToMap(MixMatchGroupListModel data) =>
    json.encode(data.toMap());

class MixMatchGroupListModel {
  MixMatchGroupListModel({
    required this.code,
    required this.message,
  });

  int code;
  MessageofMixMatchGroup? message;

  factory MixMatchGroupListModel.fromMap(Map<String, dynamic> json) =>
      MixMatchGroupListModel(
        code: json["code"] == null ? 0 : json["code"],
        message: json["message"] == null
            ? MessageofMixMatchGroup(
                currentPage: 0,
                data: [],
                firstPageUrl: '',
                from: 0,
                lastPage: 0,
                lastPageUrl: '',
                links: [],
                nextPageUrl: '',
                path: '',
                perPage: 0,
                prevPageUrl: '',
                to: 0,
                total: 0)
            : MessageofMixMatchGroup.fromMap(json["message"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message!.toMap(),
      };
}

class MessageofMixMatchGroup {
  MessageofMixMatchGroup({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<DatumofMixMatchGroup>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<LinkofMixMatchGroup>? links;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory MessageofMixMatchGroup.fromMap(Map<String, dynamic> json) =>
      MessageofMixMatchGroup(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? null
            : List<DatumofMixMatchGroup>.from(
                json["data"].map((x) => DatumofMixMatchGroup.fromMap(x))),
        firstPageUrl: json["first_page_url"] == null
            ? null.toString()
            : json["first_page_url"],
        from: json["from"] == null ? 0 : json["from"],
        lastPage: json["last_page"] == null ? 0 : json["last_page"],
        lastPageUrl: json["last_page_url"] == null
            ? null.toString()
            : json["last_page_url"],
        links: json["links"] == null
            ? null
            : List<LinkofMixMatchGroup>.from(
                json["links"].map((x) => LinkofMixMatchGroup.fromMap(x))),
        nextPageUrl: json["next_page_url"] == null
            ? null.toString()
            : json["next_page_url"],
        path: json["path"] == null ? null.toString() : json["path"],
        perPage: json["per_page"] == null ? 0 : json["per_page"],
        prevPageUrl:
            json["prev_page_url"] == null ? " " : json["prev_page_url"],
        to: json["to"] == null ? 0 : json["to"],
        total: json["total"] == null ? 0 : json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl.toString(),
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class DatumofMixMatchGroup {
  DatumofMixMatchGroup({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory DatumofMixMatchGroup.fromMap(Map<String, dynamic> json) =>
      DatumofMixMatchGroup(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class LinkofMixMatchGroup {
  LinkofMixMatchGroup({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory LinkofMixMatchGroup.fromMap(Map<String, dynamic> json) =>
      LinkofMixMatchGroup(
        url: json["url"] == null ? null.toString() : json["url"],
        label: json["label"] == null ? null : json["label"],
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? null.toString() : url,
        "label": label == null ? null.toString() : label,
        "active": active == null ? null.toString() : active,
      };
}
