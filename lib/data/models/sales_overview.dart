// To parse this JSON data, do
//
//     final saleOverViewModel = saleOverViewModelFromMap(jsonString);

import 'dart:convert';

SaleOverViewModel saleOverViewModelFromMap(String str) =>
    SaleOverViewModel.fromMap(json.decode(str));

String saleOverViewModelToMap(SaleOverViewModel data) =>
    json.encode(data.toMap());

class SaleOverViewModel {
  SaleOverViewModel({
    required this.code,
    required this.message,
    required this.sumValue,
    required this.data,
  });

  int code;
  String message;
  double sumValue;
  List<Datum>? data;

  factory SaleOverViewModel.fromMap(Map<String, dynamic> json) =>
      SaleOverViewModel(
        code: json["code"] == null ? 0 : json["code"],
        message: json["message"] == '' ? null : json["message"],
        sumValue: json["sum_value"] == null ? 0 : json["sum_value"].toDouble(),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "sum_value": sumValue == null ? null : sumValue,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.totalPaid,
    required this.share,
    required this.dateTime,
    required this.amountinPrecent,
  });

  int id;
  String name;
  double totalPaid;
  double amountinPrecent;
  double share;
  DateTime? dateTime;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        totalPaid:
            json["total_paid"] == null ? null : json["total_paid"].toDouble(),
        share: json["share"] == null ? null : json["share"].toDouble(),
        dateTime: json["dateTime"] == null ? DateTime.now() : json["dateTime"],
        amountinPrecent:
            json["amountinPrecent"] == null ? 0.0 : json["amountinPrecent"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "total_paid": totalPaid == null ? null : totalPaid,
        "share": share == null ? null : share,
      };
}
