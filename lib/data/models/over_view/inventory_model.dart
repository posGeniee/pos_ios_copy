// To parse this JSON data, do
//
//     final inventoryModelOverView = inventoryModelOverViewFromMap(jsonString);

import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';
import 'dart:convert';

InventoryModelOverView inventoryModelOverViewFromMap(String str) =>
    InventoryModelOverView.fromMap(json.decode(str));

String inventoryModelOverViewToMap(InventoryModelOverView data) =>
    json.encode(data.toMap());

class InventoryModelOverView {
  InventoryModelOverView({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data data;

  factory InventoryModelOverView.fromMap(Map<String, dynamic> json) =>
      InventoryModelOverView(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? Data(
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
            : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toMap(),
      };
}

class Data {
  Data({
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
  List<InventoryModelOverViewDatum> data;
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

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? []
            : List<InventoryModelOverViewDatum>.from(json["data"]
                .map((x) => InventoryModelOverViewDatum.fromMap(x))),
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
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
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

class InventoryModelOverViewDatum {
  InventoryModelOverViewDatum({
    required this.id,
    required this.name,
    required this.stock,
    required this.unitPrice,
    required this.book,
    required this.live,
  });

  int id;
  String name;
  String stock;
  String unitPrice;
  String book;
  int live;

  factory InventoryModelOverViewDatum.fromMap(Map<String, dynamic> json) =>
      InventoryModelOverViewDatum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        stock: json["stock"] == null ? null : json["stock"],
        unitPrice: json["unit_price"] == null ? null : json["unit_price"],
        book: json["book"] == null ? null : json["book"],
        live: json["live"] == null ? null : json["live"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "stock": stock == null ? null : stock,
        "unit_price": unitPrice == null ? null : unitPrice,
        "book": book == null ? null : book,
        "live": live == null ? null : live,
      };
}
