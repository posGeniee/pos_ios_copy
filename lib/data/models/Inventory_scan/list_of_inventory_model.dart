// To parse this JSON data, do
//
//     final inventoryListModel = inventoryListModelFromMap(jsonString);

import 'dart:convert';

InventoryListModel inventoryListModelFromMap(String str) =>
    InventoryListModel.fromMap(json.decode(str));

String inventoryListModelToMap(InventoryListModel data) =>
    json.encode(data.toMap());

class InventoryListModel {
  InventoryListModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<DatumInventoryListModel>? data;

  factory InventoryListModel.fromMap(Map<String, dynamic> json) =>
      InventoryListModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? []
            : List<DatumInventoryListModel>.from(
                json["data"].map((x) => DatumInventoryListModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class DatumInventoryListModel {
  DatumInventoryListModel({
    required this.id,
    required this.transactionDate,
    required this.refNo,
    required this.locationName,
    required this.adjustmentType,
    required this.finalTotal,
    required this.totalAmountRecovered,
    required this.additionalNotes,
    required this.dtRowId,
    required this.addedBy,
  });

  int id;
  DateTime? transactionDate;
  String refNo;
  String locationName;
  String adjustmentType;
  String finalTotal;
  String totalAmountRecovered;
  String additionalNotes;
  int dtRowId;
  String addedBy;

  factory DatumInventoryListModel.fromMap(Map<String, dynamic> json) =>
      DatumInventoryListModel(
        id: json["id"] == null ? 0 : json["id"],
        transactionDate: json["transaction_date"] == null
            ? DateTime.parse("2022-01-29 22:27:00")
            : DateTime.parse(json["transaction_date"]),
        refNo: json["ref_no"] == null ? '' : json["ref_no"],
        locationName:
            json["location_name"] == null ? '' : json["location_name"],
        adjustmentType:
            json["adjustment_type"] == null ? '' : json["adjustment_type"],
        finalTotal: json["final_total"] == null ? '0.0' : json["final_total"],
        totalAmountRecovered: json["total_amount_recovered"] == null
            ? ''
            : json["total_amount_recovered"],
        additionalNotes:
            json["additional_notes"] == null ? '' : json["additional_notes"],
        dtRowId: json["DT_RowId"] == null ? 0 : json["DT_RowId"],
        addedBy: json["added_by"] == null ? '' : json["added_by"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "transaction_date":
            transactionDate == null ? null : transactionDate!.toIso8601String(),
        "ref_no": refNo == null ? null : refNo,
        "location_name": locationName == null ? null : locationName,
        "adjustment_type": adjustmentType == null ? null : adjustmentType,
        "final_total": finalTotal == null ? null : finalTotal,
        "total_amount_recovered":
            totalAmountRecovered == null ? null : totalAmountRecovered,
        "additional_notes": additionalNotes == null ? null : additionalNotes,
        "DT_RowId": dtRowId == null ? null : dtRowId,
        "added_by": addedBy == null ? null : addedBy,
      };
}
