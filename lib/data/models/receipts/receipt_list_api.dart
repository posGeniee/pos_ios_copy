// To parse this JSON data, do
//
//     final receiptListApi = receiptListApiFromMap(jsonString);

import 'dart:convert';

ReceiptListApi receiptListApiFromMap(String str) =>
    ReceiptListApi.fromMap(json.decode(str));

String receiptListApiToMap(ReceiptListApi data) => json.encode(data.toMap());

class ReceiptListApi {
  ReceiptListApi({
    required this.code,
    required this.message,
  });

  int code;
  ReceiptListApiMessage? message;

  factory ReceiptListApi.fromMap(Map<String, dynamic> json) => ReceiptListApi(
        code: json["code"] == null ? 0 : json["code"],
        message: json["message"] == null
            ? ReceiptListApiMessage(
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
            : ReceiptListApiMessage.fromMap(json["message"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? 0 : code,
        "message": message == null ? null.toString() : message!.toMap(),
      };
}

class ReceiptListApiMessage {
  ReceiptListApiMessage({
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
  List<ReceiptListApiDatum>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<ReceiptListApiLink>? links;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory ReceiptListApiMessage.fromMap(Map<String, dynamic> json) =>
      ReceiptListApiMessage(
        currentPage: json["current_page"] == null ? '0' : json["current_page"],
        data: json["data"] == null
            ? null
            : List<ReceiptListApiDatum>.from(
                json["data"].map((x) => ReceiptListApiDatum.fromMap(x))),
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
            : List<ReceiptListApiLink>.from(
                json["links"].map((x) => ReceiptListApiLink.fromMap(x))),
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

class ReceiptListApiDatum {
  ReceiptListApiDatum({
    required this.id,
    required this.receipts,
    required this.time,
    required this.total,
    required this.employee,
    required this.type,
    required this.reg,
    required this.status,
  });

  int id;
  String receipts;
  DateTime? time;
  String total;
  String employee;
  String type;
  int reg;
  String status;

  factory ReceiptListApiDatum.fromMap(Map<String, dynamic> json) =>
      ReceiptListApiDatum(
        id: json["id"] == null ? null.toString() : json["id"],
        receipts: json["Receipts"] == null ? null.toString() : json["Receipts"],
        time: json["time"] == null
            ? DateTime.now()
            : DateTime.parse(json["time"]),
        total: json["total"] == null ? null.toString() : json["total"],
        employee: json["employee"] == null ? null.toString() : json["employee"],
        type: json["type"] == null ? null.toString() : json["type"],
        reg: json["reg"] == null ? 0 : json["reg"],
        status: json["status"] == null ? 0 : json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null.toString() : id,
        "Receipts": receipts == null ? null.toString() : receipts,
        "time": time == null ? null.toString() : time!.toIso8601String(),
        "total": total == null ? null.toString() : total,
        "employee": employee == null ? null.toString() : employee,
        "type": type == null ? null.toString() : type,
        "reg": reg == null ? 0 : reg,
      };
}

class ReceiptListApiLink {
  ReceiptListApiLink({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory ReceiptListApiLink.fromMap(Map<String, dynamic> json) =>
      ReceiptListApiLink(
        url: json["url"] == null ? null.toString() : json["url"],
        label: json["label"] == null ? null.toString() : json["label"],
        active: json["active"] == null ? null.toString() : json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? null.toString() : url,
        "label": label == null ? null.toString() : label,
        "active": active == null ? null.toString() : active,
      };
}
