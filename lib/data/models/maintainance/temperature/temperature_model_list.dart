// To parse this JSON data, do
//
//     final temperatureModel = temperatureModelFromJson(jsonString);

import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';
import 'dart:convert';

TemperatureModel temperatureModelFromJson(String str) =>
    TemperatureModel.fromJson(json.decode(str));

String temperatureModelToJson(TemperatureModel data) =>
    json.encode(data.toJson());

class TemperatureModel {
  TemperatureModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  TemperatureModelData data;

  factory TemperatureModel.fromJson(Map<String, dynamic> json) =>
      TemperatureModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? TemperatureModelData(
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
            : TemperatureModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class TemperatureModelData {
  TemperatureModelData({
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
  List<TemperatureModelDatum> data;
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

  factory TemperatureModelData.fromJson(Map<String, dynamic> json) =>
      TemperatureModelData(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? []
            : List<TemperatureModelDatum>.from(
                json["data"].map((x) => TemperatureModelDatum.fromJson(x))),
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

class TemperatureModelDatum {
  TemperatureModelDatum({
    required this.machine,
    required this.date,
    required this.temperature,
    required this.id,
  });

  String machine;
  DateTime date;
  String temperature;
  int id;

  factory TemperatureModelDatum.fromJson(Map<String, dynamic> json) =>
      TemperatureModelDatum(
        machine: json["machine"] == null ? '' : json["machine"],
        date: json["date"] == null
            ? DateTime.now()
            : DateTime.parse(json["date"]),
        temperature: json["temperature"] == null ? '' : json["temperature"],
        id: json["id"] == null ? 0 : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "machine": machine == null ? null : machine,
        "date": date == null ? null : date.toIso8601String(),
        "temperature": temperature == null ? null : temperature,
        "id": id == null ? null : id,
      };
}
