// To parse this JSON data, do
//
//     final partCategoryModel = partCategoryModelFromJson(jsonString);

import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';
import 'dart:convert';

PartCategoryModel partCategoryModelFromJson(String str) =>
    PartCategoryModel.fromJson(json.decode(str));

String partCategoryModelToJson(PartCategoryModel data) =>
    json.encode(data.toJson());

class PartCategoryModel {
  PartCategoryModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  PartCategoryData data;

  factory PartCategoryModel.fromJson(Map<String, dynamic> json) =>
      PartCategoryModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? PartCategoryData(
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
            : PartCategoryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class PartCategoryData {
  PartCategoryData({
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
  List<PartCategoryDatum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<PurchaseBulkScanLink> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory PartCategoryData.fromJson(Map<String, dynamic> json) =>
      PartCategoryData(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? []
            : List<PartCategoryDatum>.from(
                json["data"].map((x) => PartCategoryDatum.fromJson(x))),
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

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "links": links == null
            ? null
            : List<dynamic>.from(links.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class PartCategoryDatum {
  PartCategoryDatum({
    required this.id,
    required this.businessId,
    required this.locationId,
    required this.name,
    required this.profit,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int businessId;
  String locationId;
  String name;
  dynamic profit;
  int createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory PartCategoryDatum.fromJson(Map<String, dynamic> json) =>
      PartCategoryDatum(
        id: json["id"] == null ? 0 : json["id"],
        businessId: json["business_id"] == null ? 0 : json["business_id"],
        locationId: json["location_id"] == null ? 0 : json["location_id"],
        name: json["name"] == null ? '' : json["name"],
        profit: json["profit"] == null ? '' : json["profit"],
        createdBy: json["created_by"] == null ? 0 : json["created_by"],
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "business_id": businessId == null ? null : businessId,
        "location_id": locationId == null ? null : locationId,
        "name": name == null ? null : name,
        "profit": profit == null ? null : profit,
        "created_by": createdBy == null ? null : createdBy,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
