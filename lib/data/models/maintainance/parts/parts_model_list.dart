// To parse this JSON data, do
//
//     final partsListModel = partsListModelFromMap(jsonString);

import 'dart:convert';

import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';

PartsListModel partsListModelFromMap(String str) =>
    PartsListModel.fromMap(json.decode(str));

String partsListModelToMap(PartsListModel data) => json.encode(data.toMap());

class PartsListModel {
  PartsListModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  PartsListModelData? data;

  factory PartsListModel.fromMap(Map<String, dynamic> json) => PartsListModel(
        code: json["code"] == null ? null.toString() : json["code"],
        message: json["message"] == null ? null.toString() : json["message"],
        data: json["data"] == null
            ? PartsListModelData(
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
                total: 0,
              )
            : PartsListModelData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null.toString() : code,
        "message": message == null ? null.toString() : message,
        "data": data == null ? null.toString() : data!.toMap(),
      };
}

class PartsListModelData {
  PartsListModelData({
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
  List<PartsListModelDatum>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<PurchaseBulkScanLink>? links;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory PartsListModelData.fromMap(Map<String, dynamic> json) =>
      PartsListModelData(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? null
            : List<PartsListModelDatum>.from(
                json["data"].map((x) => PartsListModelDatum.fromMap(x))),
        firstPageUrl:
            json["first_page_url"] == null ? '' : json["first_page_url"],
        from: json["from"] == null ? 0 : json["from"],
        lastPage: json["last_page"] == null ? 0 : json["last_page"],
        lastPageUrl: json["last_page_url"] == null ? '' : json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<PurchaseBulkScanLink>.from(
                json["links"].map((x) => PurchaseBulkScanLink.fromMap(x))),
        nextPageUrl: json["nextPageUrl"] == null ? '' : json["nextPageUrl"],
        path: json["path"] == null ? '' : json["path"],
        perPage: json["per_page"] == null ? 0 : json["per_page"],
        prevPageUrl: json["prev_page_url"] == null ? '' : json["prev_page_url"],
        to: json["to"] == null ? 0 : json["to"],
        total: json["total"] == null ? 0 : json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage == null ? null.toString() : currentPage,
        "data": data == null
            ? null.toString()
            : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl == null ? null.toString() : firstPageUrl,
        "from": from == null ? null.toString() : from,
        "last_page": lastPage == null ? null.toString() : lastPage,
        "last_page_url": lastPageUrl == null ? null.toString() : lastPageUrl,
        "links": links == null
            ? null.toString()
            : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl == null ? null.toString() : nextPageUrl,
        "path": path == null ? null.toString() : path,
        "per_page": perPage == null ? null.toString() : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null.toString() : to,
        "total": total == null ? null.toString() : total,
      };
}

class PartsListModelDatum {
  PartsListModelDatum({
    required this.image,
    required this.name,
    required this.note,
    required this.id,
    required this.displayUrl,
  });

  String image;
  String name;
  String note;
  int id;
  String displayUrl;

  factory PartsListModelDatum.fromMap(Map<String, dynamic> json) =>
      PartsListModelDatum(
        image: json["image"] == null ? null.toString() : json["image"],
        name: json["name"] == null ? null.toString() : json["name"],
        note: json["note"] == null ? '' : json["note"],
        id: json["id"] == null ? 0 : json["id"],
        displayUrl:
            json["display_url"] == null ? null.toString() : json["display_url"],
      );

  Map<String, dynamic> toMap() => {
        "image": image == null ? null.toString() : image,
        "name": name == null ? null.toString() : name,
        "note": note == null ? null.toString() : note,
        "id": id == null ? null.toString() : id,
        "display_url": displayUrl == null ? null.toString() : displayUrl,
      };
}
