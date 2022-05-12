// To parse this JSON data, do
//
//     final customerListModel = customerListModelFromMap(jsonString);

import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';
import 'dart:convert';

CustomerListModel customerListModelFromMap(String str) =>
    CustomerListModel.fromMap(json.decode(str));

String customerListModelToMap(CustomerListModel data) =>
    json.encode(data.toMap());

class CustomerListModel {
  CustomerListModel({
    required this.code,
    required this.messsage,
    required this.data,
  });

  int code;
  String messsage;
  CustomerListModelData? data;

  factory CustomerListModel.fromMap(Map<String, dynamic> json) =>
      CustomerListModel(
        code: json["code"] == null ? null : json["code"],
        messsage: json["messsage"] == null ? null : json["messsage"],
        data: json["data"] == null
            ? CustomerListModelData(
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
            : CustomerListModelData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "messsage": messsage == null ? null : messsage,
        "data": data == null ? null : data!.toMap(),
      };
}

class CustomerListModelData {
  CustomerListModelData({
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
  List<CustomerListModelDatum>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<PurchaseBulkScanLink>? links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory CustomerListModelData.fromMap(Map<String, dynamic> json) =>
      CustomerListModelData(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<CustomerListModelDatum>.from(
                json["data"].map((x) => CustomerListModelDatum.fromMap(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? 0 : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        links: json["links"] == null
            ? null
            : List<PurchaseBulkScanLink>.from(
                json["links"].map((x) => PurchaseBulkScanLink.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? 0 : json["to"],
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

class CustomerListModelDatum {
  CustomerListModelDatum({
    required this.id,
    required this.fullName,
  });

  int id;
  String fullName;

  factory CustomerListModelDatum.fromMap(Map<String, dynamic> json) =>
      CustomerListModelDatum(
        id: json["id"] == null ? null : json["id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "full_name": fullName == null ? null : fullName,
      };
}
