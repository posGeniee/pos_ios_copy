// To parse this JSON data, do
//
//     final machineListModel = machineListModelFromMap(jsonString);

import 'dart:convert';

import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';
import 'package:http/retry.dart';

MachineListModel machineListModelFromMap(String str) =>
    MachineListModel.fromMap(json.decode(str));

String machineListModelToMap(MachineListModel data) =>
    json.encode(data.toMap());

class MachineListModel {
  MachineListModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  MachineListModelData? data;

  factory MachineListModel.fromMap(Map<String, dynamic> json) =>
      MachineListModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? MachineListModelData(
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
            : MachineListModelData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
      };
}

class MachineListModelData {
  MachineListModelData({
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
  List<MachineListModelDatum>? data;
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

  factory MachineListModelData.fromMap(Map<String, dynamic> json) =>
      MachineListModelData(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<MachineListModelDatum>.from(
                json["data"].map((x) => MachineListModelDatum.fromMap(x))),
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

class MachineListModelDatum {
  MachineListModelDatum({
    required this.number,
    required this.name,
    required this.temperature,
    required this.id,
    required this.isSelected,
    required this.displayUrl,
  });

  String number;
  String name;
  String temperature;
  int id;
  bool isSelected;
  String displayUrl;

  factory MachineListModelDatum.fromMap(Map<String, dynamic> json) =>
      MachineListModelDatum(
        number: json["number"] == null ? '' : json["number"],
        name: json["name"] == null ? '' : json["name"],
        temperature: json["temperature"] == null ? '' : json["temperature"],
        id: json["id"] == null ? 0 : json["id"],
        isSelected: json["isSelected"] == null ? false : json["isSelected"],
        displayUrl: json["display_url"] == null ? '' : json["display_url"],
      );

  Map<String, dynamic> toMap() => {
        "number": number == null ? '' : number,
        "name": name == null ? '' : name,
        "temperature": temperature == null ? '' : temperature,
        "id": id == null ? 0 : id,
        "display_url": displayUrl == null ? '' : displayUrl,
      };
}
