// To parse this JSON data, do
//
//     final getLocationsModel = getLocationsModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetLocationsModel getLocationsModelFromMap(String str) => GetLocationsModel.fromMap(json.decode(str));

String getLocationsModelToMap(GetLocationsModel data) => json.encode(data.toMap());

class GetLocationsModel {
  GetLocationsModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<GetLocationDatum>? data;

  factory GetLocationsModel.fromMap(Map<String, dynamic> json) => GetLocationsModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<GetLocationDatum>.from(json["data"].map((x) => GetLocationDatum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class GetLocationDatum {
  GetLocationDatum({
    required this.locationId,
    required this.name,
  });

  int locationId;
  String name;

  factory GetLocationDatum.fromMap(Map<String, dynamic> json) => GetLocationDatum(
    locationId: json["location_id"] == null ? 0 : json["location_id"],
    name: json["name"] == null ? '' : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "location_id": locationId == null ? null : locationId,
    "name": name == null ? null : name,
  };
}
