// To parse this JSON data, do
//
//     final partOrderModel = partOrderModelFromJson(jsonString);

import 'dart:convert';
import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';

PartOrderModel partCategoryModelFromJson(String str) =>
    PartOrderModel.fromJson(json.decode(str));

String partCategoryModelToJson(PartOrderModel data) =>
    json.encode(data.toJson());

class PartOrderModel {
  PartOrderModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  PartOrderData data;

  factory PartOrderModel.fromJson(Map<String, dynamic> json) => PartOrderModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? PartOrderData(
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
            : PartOrderData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class PartOrderData {
  PartOrderData({
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
  List<PartOrderDatum> data;
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

  factory PartOrderData.fromJson(Map<String, dynamic> json) => PartOrderData(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? []
            : List<PartOrderDatum>.from(
                json["data"].map((x) => PartOrderDatum.fromJson(x))),
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

PartOrderDatum partOrderModelFromJson(String str) =>
    PartOrderDatum.fromJson(json.decode(str));

String partOrderModelToJson(PartOrderDatum data) => json.encode(data.toJson());

class PartOrderDatum {
  PartOrderDatum({
    required this.id,
    required this.partCateName,
    required this.recieveDate,
    required this.orderName,
    required this.link,
    required this.supplierName,
    required this.description,
    required this.status,
    required this.scheduleId,
    required this.partWarrantyDate,
    required this.cost,
    required this.partCateId,
  });

  int id;
  String partCateName;
  DateTime recieveDate;
  String orderName;
  String link;
  String supplierName;
  dynamic description;
  dynamic status;
  dynamic scheduleId;
  DateTime partWarrantyDate;
  String cost;
  String partCateId;

  factory PartOrderDatum.fromJson(Map<String, dynamic> json) => PartOrderDatum(
        id: json["id"] == null ? 0 : json["id"],
        partCateName:
            json["part_cate_name"] == null ? "" : json["part_cate_name"],
        recieveDate: json["recieve_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["recieve_date"]),
        orderName: json["order_name"] == null ? '' : json["order_name"],
        link: json["link"] == null ? '' : json["link"],
        supplierName:
            json["supplier_name"] == null ? '' : json["supplier_name"],
        description: json["description"] == null ? '' : json["description"],
        status: json["status"] == null ? 0 : json["status"],
        scheduleId: json["schedule_id"] == null ? 0 : json["schedule_id"],
        partWarrantyDate: json["part_warranty_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["part_warranty_date"]),
        cost: json["cost"] == null ? '0.0' : json["cost"],
        partCateId: json["part_category_id"] == null
            ? '0.0'
            : json["part_category_id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "part_cate_name": partCateName == null ? null : partCateName,
        "recieve_date":
            recieveDate == null ? null : recieveDate.toIso8601String(),
        "order_name": orderName == null ? null : orderName,
        "link": link == null ? null : link,
        "supplier_name": supplierName == null ? null : supplierName,
        "description": description,
        "status": status == null ? null : status,
        "schedule_id": scheduleId,
      };
}

// var partorderdummyData = '''
// {
//     "code": 200,
//     "message": "Record update successfully",
//     "data": {
//         "current_page": 1,
//         "data": [
//        {
//             "id": 18,
//             "part_cate_name": "iphone-rep",
//             "recieve_date": "2022-03-01 14:26:00",
//             "order_name": "sheet feedar",
//             "link": "https://www.google.com/search?q=printer+parts&oq=printer+parts&aqs=chrome.0.69i59j0i512l9.3264j0j7&sourceid=chrome&ie=UTF-8",
//             "supplier_name": "ronak vyas",
//             "description": null,
//             "status": 1,
//             "schedule_id": null
//         }
//         ],
//         "first_page_url": "$baseUrl/v2/part-category?page=1",
//         "from": 1,
//         "last_page": 1,
//         "last_page_url": "$baseUrl/v2/part-category?page=1",
//         "links": [
//             {
//                 "url": null,
//                 "label": "&laquo; Previous",
//                 "active": false
//             },
//             {
//                 "url": "$baseUrl/v2/part-category?page=1",
//                 "label": "1",
//                 "active": true
//             },
//             {
//                 "url": null,
//                 "label": "Next &raquo;",
//                 "active": false
//             }
//         ],
//         "next_page_url": null,
//         "path": "$baseUrl/v2/part-category",
//         "per_page": 10,
//         "prev_page_url": null,
//         "to": 1,
//         "total": 1
//     }
// }
// ''';
