// To parse this JSON data, do
//
//     final searchVendorModel = searchVendorModelFromMap(jsonString);

import 'dart:convert';

SearchVendorModel searchVendorModelFromMap(String str) =>
    SearchVendorModel.fromMap(json.decode(str));

String searchVendorModelToMap(SearchVendorModel data) =>
    json.encode(data.toMap());

class SearchVendorModel {
  SearchVendorModel({
    required this.code,
    required this.message,
  });

  int code;
  MessageSearchVendor? message;

  factory SearchVendorModel.fromMap(Map<String, dynamic> json) =>
      SearchVendorModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null
            ? MessageSearchVendor(
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
            : MessageSearchVendor.fromMap(json["message"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message!.toMap(),
      };
}

class MessageSearchVendor {
  MessageSearchVendor({
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
  List<DatumSearchVendor>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<LinkSearchVendor>? links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory MessageSearchVendor.fromMap(Map<String, dynamic> json) =>
      MessageSearchVendor(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<DatumSearchVendor>.from(
                json["data"].map((x) => DatumSearchVendor.fromMap(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        links: json["links"] == null
            ? null
            : List<LinkSearchVendor>.from(
                json["links"].map((x) => LinkSearchVendor.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
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
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class DatumSearchVendor {
  DatumSearchVendor({
    required this.supplier,
    required this.id,
  });

  String supplier;
  int id;

  factory DatumSearchVendor.fromMap(Map<String, dynamic> json) =>
      DatumSearchVendor(
        supplier: json["supplier"] == null ? null : json["supplier"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "supplier": supplier == null ? null : supplier,
        "id": id == null ? null : id,
      };
}

class LinkSearchVendor {
  LinkSearchVendor({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory LinkSearchVendor.fromMap(Map<String, dynamic> json) =>
      LinkSearchVendor(
        url: json["url"] == null ? null : json["url"],
        label: json["label"] == null ? null : json["label"],
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? null : url,
        "label": label == null ? null : label,
        "active": active == null ? null : active,
      };
}
