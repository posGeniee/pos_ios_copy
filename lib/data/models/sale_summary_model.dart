// To parse this JSON data, do
//
//     final saleSummaryModle = saleSummaryModleFromMap(jsonString);

import 'dart:convert';

SaleSummaryModelApi saleSummaryModleFromMap(String str) =>
    SaleSummaryModelApi.fromMap(json.decode(str));

String saleSummaryModleToMap(SaleSummaryModelApi data) =>
    json.encode(data.toMap());

class SaleSummaryModelApi {
  SaleSummaryModelApi({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  DataSaleSummaryModelApi? data;

  factory SaleSummaryModelApi.fromMap(Map<String, dynamic> json) =>
      SaleSummaryModelApi(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? DataSaleSummaryModelApi(
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
            : DataSaleSummaryModelApi.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
        "data": data == null ? null : data!.toMap(),
      };
}

class DataSaleSummaryModelApi {
  DataSaleSummaryModelApi({
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
  List<DatumSaleSummaryModelApi>? data;
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

  factory DataSaleSummaryModelApi.fromMap(
          Map<String, dynamic> json) =>
      DataSaleSummaryModelApi(
          currentPage: json["current_page"],
          data: json["data"] == null
              ? []
              : List<DatumSaleSummaryModelApi>.from(
                  json["data"].map((x) => DatumSaleSummaryModelApi.fromMap(x))),
          firstPageUrl:
              json["first_page_url"] == null ? '' : json["first_page_url"],
          from: json["from"] == null ? 0 : json["from"],
          lastPage: json["last_page"] == null ? 0 : json["last_page"],
          lastPageUrl:
              json["last_page_url"] == null ? '' : json["last_page_url"],
          links: json["links"] == null
              ? []
              : List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
          nextPageUrl: json["next_page_url"].toString(),
          path: json["path"],
          perPage: json["per_page"] == null ? 0 : json["per_page"],
          prevPageUrl:
              json["prev_page_url"] == null ? '' : json["prev_page_url"],
          to: json["to"] == null ? 0 : json["to"],
          total: json["total"] == null ? 0 : json["total"]
          // json["total"],
          );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class DatumSaleSummaryModelApi {
  DatumSaleSummaryModelApi({
    required this.productId,
    required this.qty,
    required this.itemName,
    required this.totalPaid,
    required this.share,
  });

  int productId;
  String qty;
  String itemName;
  String totalPaid;
  double share;

  factory DatumSaleSummaryModelApi.fromMap(Map<String, dynamic> json) =>
      DatumSaleSummaryModelApi(
        productId: json["product_id"],
        qty: json["qty"],
        itemName: json["item_name"],
        totalPaid: json["total_paid"] == null ? '0.0' : json["total_paid"],
        // json["total_paid"],
        share: json["share"] == null ? null : json["share"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "qty": qty,
        "item_name": itemName,
        "total_paid": totalPaid,
        "share": share,
      };
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"] ?? "",
        label: json["label"] ?? "",
        active: json["active"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
