// To parse this JSON data, do
//
//     final partsListModel = partsListModelFromMap(jsonString);

import 'dart:convert';

import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';

DecisionModel decisionListModelFromMap(String str) =>
    DecisionModel.fromMap(json.decode(str));

String decisionListModelToMap(DecisionModel data) => json.encode(data.toMap());

class DecisionModel {
  DecisionModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  DecisionModelData? data;

  factory DecisionModel.fromMap(Map<String, dynamic> json) => DecisionModel(
        code: json["code"] == null ? null.toString() : json["code"],
        message: json["message"] == null ? null.toString() : json["message"],
        data: json["data"] == null
            ? DecisionModelData(
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
            : DecisionModelData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null.toString() : code,
        "message": message == null ? null.toString() : message,
        "data": data == null ? null.toString() : data!.toMap(),
      };
}

class DecisionModelData {
  DecisionModelData({
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
  List<DecisionModelDatum>? data;
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

  factory DecisionModelData.fromMap(Map<String, dynamic> json) =>
      DecisionModelData(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? null
            : List<DecisionModelDatum>.from(
                json["data"].map((x) => DecisionModelDatum.fromJson(x))),
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
            : List<dynamic>.from(data!.map((x) => x.toJson())),
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

class DecisionModelDatum {
  DecisionModelDatum({
    required this.id,
    required this.description,

    // required this.apiLocation,
  });

  int id;
  String description;

  // List<ApiLocation> apiLocation;

  factory DecisionModelDatum.fromJson(Map<String, dynamic> json) =>
      DecisionModelDatum(
        id: json["id"] == null ? 0 : json["id"],
        description: json["description"] == null ? '' : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "description": description == null ? null : description,
      };
}
