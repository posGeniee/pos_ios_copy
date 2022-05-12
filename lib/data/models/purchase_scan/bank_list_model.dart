import 'dart:convert';

BankListModel bankListModelFromMap(String str) =>
    BankListModel.fromMap(json.decode(str));

String bankListModelToMap(BankListModel data) => json.encode(data.toMap());

class BankListModel {
  BankListModel({
    required this.code,
    required this.message,
  });

  int code;
  List<BankListModelMessage>? message;

  factory BankListModel.fromMap(Map<String, dynamic> json) => BankListModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null
            ? []
            : List<BankListModelMessage>.from(
                json["message"].map((x) => BankListModelMessage.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null
            ? null
            : List<dynamic>.from(message!.map((x) => x.toMap())),
      };
}

class BankListModelMessage {
  BankListModelMessage({
    required this.bankName,
    required this.id,
  });

  String bankName;
  int id;

  factory BankListModelMessage.fromMap(Map<String, dynamic> json) =>
      BankListModelMessage(
        bankName: json["bank_name"] == null ? null : json["bank_name"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "bank_name": bankName == null ? null : bankName,
        "id": id == null ? null : id,
      };
}
