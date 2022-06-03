// To parse this JSON data, do
//
//     final updateTerminalModel = updateTerminalModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateTerminalModel updateTerminalModelFromMap(String str) => UpdateTerminalModel.fromMap(json.decode(str));

String updateTerminalModelToMap(UpdateTerminalModel data) => json.encode(data.toMap());

class UpdateTerminalModel {
  UpdateTerminalModel({
    required this.code,
    required this.message,
  });

  int code;
  String message;

  factory UpdateTerminalModel.fromMap(Map<String, dynamic> json) => UpdateTerminalModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}
