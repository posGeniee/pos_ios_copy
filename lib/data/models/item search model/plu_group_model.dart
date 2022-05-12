// To parse this JSON data, do
//
//     final pluGroupListApi = pluGroupListApiFromMap(jsonString);

import 'dart:convert';

PluGroupListApi pluGroupListApiFromMap(String str) =>
    PluGroupListApi.fromMap(json.decode(str));

String pluGroupListApiToMap(PluGroupListApi data) => json.encode(data.toMap());

class PluGroupListApi {
  PluGroupListApi({
    required this.code,
    required this.message,
  });

  int code;
  MessagePluGroupList? message;

  factory PluGroupListApi.fromMap(Map<String, dynamic> json) => PluGroupListApi(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null
            ? MessagePluGroupList(
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
            : MessagePluGroupList.fromMap(json["message"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message!.toMap(),
      };
}

class MessagePluGroupList {
  MessagePluGroupList({
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
  List<DatumPluGroupList>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<LinkPluGroupList>? links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory MessagePluGroupList.fromMap(Map<String, dynamic> json) =>
      MessagePluGroupList(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? []
            : List<DatumPluGroupList>.from(
                json["data"].map((x) => DatumPluGroupList.fromMap(x))),
        firstPageUrl:
            json["first_page_url"] == null ? '' : json["first_page_url"],
        from: json["from"] == null ? 0 : json["from"],
        lastPage: json["last_page"] == null ? 0 : json["last_page"],
        lastPageUrl: json["last_page_url"] == null ? '' : json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<LinkPluGroupList>.from(
                json["links"].map((x) => LinkPluGroupList.fromMap(x))),
        nextPageUrl: json["next_page_url"] == null ? '' : json["next_page_url"],
        path: json["path"] == null ? '' : json["path"],
        perPage: json["per_page"] == 0 ? 0 : json["per_page"],
        prevPageUrl: json["prev_page_url"] == 0 ? '' : json["prev_page_url"],
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
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl.toString(),
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class DatumPluGroupList {
  DatumPluGroupList({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory DatumPluGroupList.fromMap(Map<String, dynamic> json) =>
      DatumPluGroupList(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class LinkPluGroupList {
  LinkPluGroupList({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory LinkPluGroupList.fromMap(Map<String, dynamic> json) =>
      LinkPluGroupList(
        url: json["url"] == null ? null.toString() : json["url"],
        label: json["label"] == null ? null : json["label"],
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? null : url,
        "label": label == null ? null : label,
        "active": active == null ? null : active,
      };
}
