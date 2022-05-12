// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';

NotesModel notesModelFromJson(String str) =>
    NotesModel.fromJson(json.decode(str));

String notesModelToJson(NotesModel data) => json.encode(data.toJson());

class NotesModel {
  NotesModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  NotesModelData data;

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? NotesModelData(
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
            : NotesModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class NotesModelData {
  NotesModelData({
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
  List<NotesModelDatum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<PurchaseBulkScanLink> links;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory NotesModelData.fromJson(Map<String, dynamic> json) => NotesModelData(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? []
            : List<NotesModelDatum>.from(
                json["data"].map((x) => NotesModelDatum.fromJson(x))),
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
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class NotesModelDatum {
  NotesModelDatum({
    required this.machine,
    required this.date,
    required this.createdBy,
    required this.id,
    required this.status,
    required this.assignedTo,
    required this.cost,
    required this.document,
    required this.documentType,
    required this.displayUrl,
    required this.desc,
    required this.description,
  });

  String machine;
  DateTime date;
  dynamic createdBy;
  int id;
  String status;
  String assignedTo;
  String cost;
  dynamic document;
  String documentType;
  String displayUrl;
  String desc;
  String description;

  factory NotesModelDatum.fromJson(Map<String, dynamic> json) =>
      NotesModelDatum(
        machine: json["machine"] == null ? '' : json["machine"],
        date: json["date"] == null
            ? DateTime.now()
            : DateTime.parse(json["date"]),
        createdBy: json["created_by"] == null ? '' : json["created_by"],
        id: json["id"] == null ? null : json["id"],
        status: json["status"] == null ? '' : json["status"],
        assignedTo: json["assigned_to"] == null ? '' : json["assigned_to"],
        cost: json["cost"] == null ? '' : json["cost"],
        document: json["document"] == null ? '' : json["document"],
        documentType:
            json["document_type"] == null ? '' : json["document_type"],
        displayUrl: json["display_url"] == null ? '' : json["display_url"],
        desc: json["desc"] == null ? '' : json["desc"],
        description: json["description"] == null ? '' : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "machine": machine == null ? null : machine,
        "date": date == null ? null : date.toIso8601String(),
        "created_by": createdBy == null ? null : createdBy,
        "id": id == null ? null : id,
        "status": status == null ? null : status,
        "assigned_to": assignedTo == null ? null : assignedTo,
        "cost": cost == null ? null : cost,
        "document": document,
        "document_type": documentType == null ? null : documentType,
        "display_url": displayUrl == null ? null : displayUrl,
      };
}
