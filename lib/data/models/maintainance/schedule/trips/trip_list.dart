// To parse this JSON data, do
//
//     final partsListModel = partsListModelFromMap(jsonString);

import 'dart:convert';

import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';

TripModel tripListModelFromMap(String str) =>
    TripModel.fromMap(json.decode(str));

String tripListModelToMap(TripModel data) => json.encode(data.toMap());

class TripModel {
  TripModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  TripModelData? data;

  factory TripModel.fromMap(Map<String, dynamic> json) => TripModel(
        code: json["code"] == null ? null.toString() : json["code"],
        message: json["message"] == null ? null.toString() : json["message"],
        data: json["data"] == null
            ? TripModelData(
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
            : TripModelData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null.toString() : code,
        "message": message == null ? null.toString() : message,
        "data": data == null ? null.toString() : data!.toMap(),
      };
}

class TripModelData {
  TripModelData({
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
  List<TripModelDatum>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<PurchaseBulkScanLink>? links;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory TripModelData.fromMap(Map<String, dynamic> json) => TripModelData(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? null
            : List<TripModelDatum>.from(
                json["data"].map((x) => TripModelDatum.fromJson(x))),
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
        "current_page": currentPage == null ? null.toString() : currentPage,
        "data": data == null
            ? null.toString()
            : List<dynamic>.from(data!.map((x) => x.toJson())),
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

class TripModelDatum {
  TripModelDatum({
    required this.startTime,
    required this.endTime,
    required this.id,
    required this.description,
    required this.cost,
    // required this.apiLocation,
  });

  DateTime startTime;
  DateTime endTime;
  int id;
  String description;
  String cost;
  // List<ApiLocation> apiLocation;

  factory TripModelDatum.fromJson(Map<String, dynamic> json) => TripModelDatum(
        startTime: json["start_time"] == null
            ? DateTime.now()
            : DateTime.parse(json["start_time"]),
        endTime: json["end_time"] == null
            ? DateTime.now()
            : DateTime.parse(json["end_time"]),
        id: json["id"] == null ? 0 : json["id"],
        description: json["description"] == null ? '' : json["description"],
        cost: json["cost"] == null ? '' : json["cost"],
        // apiLocation: json["api_location"] == null
        //     ? []
        //     : List<ApiLocation>.from(
        //         json["api_location"].map((x) => ApiLocation.fromJson(x)),
        //       ),
      );

  Map<String, dynamic> toJson() => {
        "start_time": startTime == null ? null : startTime.toIso8601String(),
        "end_time": endTime == null ? null : endTime.toIso8601String(),
        "id": id == null ? null : id,
        "description": description == null ? null : description,
        // "api_location": apiLocation == null
        //     ? null
        //     : List<dynamic>.from(apiLocation.map((x) => x.toJson())),
      };
}

class ApiLocation {
  ApiLocation({
    required this.lat,
    required this.long,
  });

  String lat;
  String long;

  factory ApiLocation.fromJson(Map<String, dynamic> json) => ApiLocation(
        lat: json["lat"] == null ? "0.0" : json["lat"],
        long: json["long"] == null ? "0.0" : json["long"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
      };
}
