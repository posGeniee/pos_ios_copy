// To parse this JSON data, do
//
//     final getTerminalModel = getTerminalModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetTerminalModel getTerminalModelFromMap(String str) => GetTerminalModel.fromMap(json.decode(str));

String getTerminalModelToMap(GetTerminalModel data) => json.encode(data.toMap());

class GetTerminalModel {
  GetTerminalModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<GetTerminalDatum>? data;

  factory GetTerminalModel.fromMap(Map<String, dynamic> json) => GetTerminalModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<GetTerminalDatum>.from(json["data"].map((x) => GetTerminalDatum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class GetTerminalDatum {
  GetTerminalDatum({
    required this.id,
    required this.businessId,
    required this.terminalCode,
    required this.terminalName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.locationId,
  });

  int id;
  int businessId;
  String terminalCode;
  String terminalName;
  int status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int locationId;

  factory GetTerminalDatum.fromMap(Map<String, dynamic> json) => GetTerminalDatum(
    id: json["id"] == null ? 0 : json["id"],
    businessId: json["business_id"] == null ? 0 : json["business_id"],
    terminalCode: json["terminal_code"] == null ? '' : json["terminal_code"],
    terminalName: json["terminal_name"] == null ? '' : json["terminal_name"],
    status: json["status"] == null ? 0 : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    locationId: json["location_id"] == null ? 0 : json["location_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "business_id": businessId == null ? null : businessId,
    "terminal_code": terminalCode == null ? null : terminalCode,
    "terminal_name": terminalName == null ? null : terminalName,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "location_id": locationId == null ? null : locationId,
  };
}
