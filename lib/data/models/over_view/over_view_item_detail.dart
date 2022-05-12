// To parse this JSON data, do
//
//     final overViewItemDetail = overViewItemDetailFromMap(jsonString);

import 'package:dummy_app/data/models/sale_summary_model.dart';
import 'dart:convert';

OverViewItemDetailModel overViewItemDetailFromMap(String str) =>
    OverViewItemDetailModel.fromMap(json.decode(str));

String overViewItemDetailToMap(OverViewItemDetailModel data) =>
    json.encode(data.toMap());

class OverViewItemDetailModel {
  OverViewItemDetailModel({
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
  List<OverViewItemDetailModelDatum>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory OverViewItemDetailModel.fromMap(Map<String, dynamic> json) =>
      OverViewItemDetailModel(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? []
            : List<OverViewItemDetailModelDatum>.from(json["data"]
                .map((x) => OverViewItemDetailModelDatum.fromMap(x))),
        firstPageUrl:
            json["first_page_url"] == null ? '' : json["first_page_url"],
        from: json["from"] == null ? 0 : json["from"],
        lastPage: json["last_page"] == null ? 0 : json["last_page"],
        lastPageUrl: json["last_page_url"] == null ? '' : json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"] == null ? '' : json["next_page_url"],
        // json["next_page_url"],
        path: json["path"] == null ? '' : json["path"],
        perPage: json["per_page"] == null ? 0 : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? '' : json["to"],
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
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class OverViewItemDetailModelDatum {
  OverViewItemDetailModelDatum({
    required this.receipt,
    required this.qty,
    required this.time,
    required this.price,
  });

  String receipt;
  String qty;
  DateTime? time;
  String price;

  factory OverViewItemDetailModelDatum.fromMap(Map<String, dynamic> json) =>
      OverViewItemDetailModelDatum(
        receipt: json["Receipt"] == null ? null : json["Receipt"],
        qty: json["qty"] == null ? null : json["qty"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        price: json["price"] == null ? null : json["price"],
      );

  Map<String, dynamic> toMap() => {
        "Receipt": receipt == null ? null : receipt,
        "qty": qty == null ? null : qty,
        "time": time == null ? null : time!.toIso8601String(),
        "price": price == null ? null : price,
      };
}
