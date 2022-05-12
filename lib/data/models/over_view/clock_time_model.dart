// To parse this JSON data, do
//
//     final clockInModelOverView = clockInModelOverViewFromMap(jsonString);

import 'dart:convert';

ClockInModelOverView clockInModelOverViewFromMap(String str) =>
    ClockInModelOverView.fromMap(json.decode(str));

String clockInModelOverViewToMap(ClockInModelOverView data) =>
    json.encode(data.toMap());

class ClockInModelOverView {
  ClockInModelOverView({
    required this.code,
    required this.message,
    required this.data,
  });

  int? code;
  String? message;
  List<ClockInModelOverViewDatum>? data;

  factory ClockInModelOverView.fromMap(Map<String, dynamic> json) =>
      ClockInModelOverView(
        code: json["code"] ?? 0,
        message: json["message"] ?? '',
        data: json["data"] == null
            ? []
            : List<ClockInModelOverViewDatum>.from(
                json["data"].map((x) => ClockInModelOverViewDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code ?? code,
        "message": message ?? message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class ClockInModelOverViewDatum {
  ClockInModelOverViewDatum({
    required this.employeeName,
    required this.clockInTime,
    required this.clockOutTime,
    required this.clockInNote,
    required this.clockOutNote,
    required this.voids,
    required this.receipts,
    required this.status,
    required this.lines,
  });

  String? employeeName;
  DateTime? clockInTime;
  DateTime? clockOutTime;
  String? clockInNote;
  String? clockOutNote;
  int? voids;
  int? receipts;
  String? status;
  int? lines;

  factory ClockInModelOverViewDatum.fromMap(Map<String, dynamic> json) =>
      ClockInModelOverViewDatum(
        employeeName: json["employee_name"] ?? '',
        clockInTime: json["clock_in_time"] == null
            ? DateTime.now()
            : DateTime.parse(json["clock_in_time"]),
        clockOutTime: json["clock_out_time"] == null
            ? DateTime.now()
            : DateTime.parse(json["clock_out_time"]),
        clockInNote: json["clock_in_note"] ?? '',
        clockOutNote: json["clock_out_note"] ?? '',
        voids: json["voids"] ?? 0,
        receipts: json["receipts"] ?? 0,
        status: json["status"] ?? '',
        lines: json["lines"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "employee_name": employeeName ?? employeeName,
        "clock_in_time":
            clockInTime == null ? null : clockInTime!.toIso8601String(),
        "clock_out_time":
            clockOutTime == null ? null : clockOutTime!.toIso8601String(),
        "clock_in_note": clockInNote ?? clockInNote,
        "clock_out_note": clockInNote ?? clockInNote,
        "voids": voids ?? voids,
        "receipts": receipts ?? receipts,
        "status": status ?? status,
        "lines": lines ?? lines,
      };
}
