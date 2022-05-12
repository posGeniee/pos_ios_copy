// To parse this JSON data, do
//
//     final getSalesof7D15D30DModel = getSalesof7D15D30DModelFromMap(jsonString);

import 'dart:convert';

GetSalesof7D15D30DModel getSalesof7D15D30DModelFromMap(String str) =>
    GetSalesof7D15D30DModel.fromMap(json.decode(str));

String getSalesof7D15D30DModelToMap(GetSalesof7D15D30DModel data) =>
    json.encode(data.toMap());

class GetSalesof7D15D30DModel {
  GetSalesof7D15D30DModel({
    required this.code,
    required this.message,
  });

  int code;
  List<MessageGetSalesof7D15D30D>? message;

  factory GetSalesof7D15D30DModel.fromMap(Map<String, dynamic> json) =>
      GetSalesof7D15D30DModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null
            ? []
            : List<MessageGetSalesof7D15D30D>.from(json["message"]
                .map((x) => MessageGetSalesof7D15D30D.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null
            ? null
            : List<dynamic>.from(message!.map((x) => x.toMap())),
      };
}

class MessageGetSalesof7D15D30D {
  MessageGetSalesof7D15D30D({
    required this.sales,
    required this.purchases,
  });

  PurchasesGetSalesof7D15D30DGetSalesof7D15D30D? sales;
  PurchasesGetSalesof7D15D30DGetSalesof7D15D30D? purchases;

  factory MessageGetSalesof7D15D30D.fromMap(Map<String, dynamic> json) =>
      MessageGetSalesof7D15D30D(
        sales: json["sales"] == null ? null : PurchasesGetSalesof7D15D30DGetSalesof7D15D30D.fromMap(json["sales"]),
        purchases: json["purchases"] == null
            ? null
            : PurchasesGetSalesof7D15D30DGetSalesof7D15D30D.fromMap(json["purchases"]),
      );

  Map<String, dynamic> toMap() => {
        "sales": sales == null ? null : sales!.toMap(),
        "purchases": purchases == null ? null : purchases!.toMap(),
      };
}

class PurchasesGetSalesof7D15D30DGetSalesof7D15D30D {
  PurchasesGetSalesof7D15D30DGetSalesof7D15D30D({
    required this.the7Days,
    required this.the15Days,
    required this.the30Days,
  });

  int the7Days;
  int the15Days;
  int the30Days;

  factory PurchasesGetSalesof7D15D30DGetSalesof7D15D30D.fromMap(Map<String, dynamic> json) => PurchasesGetSalesof7D15D30DGetSalesof7D15D30D(
        the7Days: json["7-days"] == null ? null : json["7-days"],
        the15Days: json["15-days"] == null ? null : json["15-days"],
        the30Days: json["30-days"] == null ? null : json["30-days"],
      );

  Map<String, dynamic> toMap() => {
        "7-days": the7Days == null ? null : the7Days,
        "15-days": the15Days == null ? null : the15Days,
        "30-days": the30Days == null ? null : the30Days,
      };
}
