// To parse this JSON data, do
//
//     final vendorModel = vendorModelFromMap(jsonString);

import 'dart:convert';

VendorModel vendorModelFromMap(String str) =>
    VendorModel.fromMap(json.decode(str));

String vendorModelToMap(VendorModel data) => json.encode(data.toMap());

class VendorModel {
  VendorModel({
    required this.code,
    required this.message,
  });

  int code;
  MessageVendor? message;

  factory VendorModel.fromMap(Map<String, dynamic> json) => VendorModel(
        code: json["code"] == null ? null.toString() : json["code"],
        message: json["message"] == null
            ? MessageVendor(
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
            : MessageVendor.fromMap(json["message"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null.toString() : code,
        "message": message == null ? null.toString() : message!.toMap(),
      };
}

class MessageVendor {
  MessageVendor({
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
  List<DatumVendor>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<LinkVendor>? links;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory MessageVendor.fromMap(Map<String, dynamic> json) => MessageVendor(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? null
            : List<DatumVendor>.from(
                json["data"].map((x) => DatumVendor.fromMap(x))),
        firstPageUrl: json["first_page_url"] == null
            ? null.toString()
            : json["first_page_url"],
        from: json["from"] == null ? 0 : json["from"],
        lastPage: json["last_page"] == null ? 0 : json["last_page"],
        lastPageUrl: json["last_page_url"] == null
            ? null.toString()
            : json["last_page_url"],
        links: json["links"] == null
            ? null
            : List<LinkVendor>.from(
                json["links"].map((x) => LinkVendor.fromMap(x))),
        nextPageUrl: json["next_page_url"] == null
            ? null.toString()
            : json["next_page_url"],
        path: json["path"] == null ? null.toString() : json["path"],
        perPage: json["per_page"] == null ? 0 : json["per_page"],
        prevPageUrl: json["prev_page_url"],
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

class DatumVendor {
  DatumVendor({
    required this.supplier,
    required this.id,
  });

  String supplier;
  int id;

  factory DatumVendor.fromMap(Map<String, dynamic> json) => DatumVendor(
        supplier: json["supplier"] == null ? null.toString() : json["supplier"],
        id: json["id"] == null ? 0 : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "supplier": supplier == null ? null.toString() : supplier,
        "id": id == null ? null.toString() : id,
      };
}

class LinkVendor {
  LinkVendor({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory LinkVendor.fromMap(Map<String, dynamic> json) => LinkVendor(
        url: json["url"] == null ? null.toString() : json["url"],
        label: json["label"] == null ? null.toString() : json["label"],
        active: json["active"] == null ? false : json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? null.toString() : url,
        "label": label == null ? null.toString() : label,
        "active": active == null ? null.toString() : active,
      };
}
