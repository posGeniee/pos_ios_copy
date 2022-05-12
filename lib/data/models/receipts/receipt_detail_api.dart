
import 'dart:convert';

ReceiptDetailApi receiptDetailApiFromMap(String str) =>
    ReceiptDetailApi.fromMap(json.decode(str));

String receiptDetailApiToMap(ReceiptDetailApi data) =>
    json.encode(data.toMap());

class ReceiptDetailApi {
  ReceiptDetailApi({
    required this.code,
    required this.total,
    required this.message,
  });

  int code;
  double total;
  List<ReceiptDetailApiMessage>? message;

  factory ReceiptDetailApi.fromMap(Map<String, dynamic> json) =>
      ReceiptDetailApi(
        code: json["code"] == null ? null : json["code"],
        total: json["total"] == null ? 0 : json["total"].toDouble(),
        message: json["message"] == null
            ? []
            : List<ReceiptDetailApiMessage>.from(
                json["message"].map((x) => ReceiptDetailApiMessage.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "total": total == null ? null : total,
        "message": message == null
            ? null
            : List<dynamic>.from(message!.map((x) => x.toMap())),
      };
}

class ReceiptDetailApiMessage {
  ReceiptDetailApiMessage({
    required this.name,
    required this.qty,
    required this.amount,
  });

  String name;
  String qty;
  String amount;

  factory ReceiptDetailApiMessage.fromMap(Map<String, dynamic> json) => ReceiptDetailApiMessage(
        name: json["name"] == null ? null : json["name"],
        qty: json["qty"] == null ? null : json["qty"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "qty": qty == null ? null : qty,
        "amount": amount == null ? null : amount,
      };
}
