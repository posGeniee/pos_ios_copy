// To parse this JSON data, do
//
//     final gasPriceApiModel = gasPriceApiModelFromMap(jsonString);

import 'dart:convert';

GasPriceApiModel gasPriceApiModelFromMap(String str) =>
    GasPriceApiModel.fromMap(json.decode(str));

String gasPriceApiModelToMap(GasPriceApiModel data) =>
    json.encode(data.toMap());

class GasPriceApiModel {
  GasPriceApiModel({
    required this.code,
    required this.message,
  });

  int code;
  List<GasPriceApiModelMessage>? message;

  factory GasPriceApiModel.fromMap(Map<String, dynamic> json) =>
      GasPriceApiModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null
            ? null
            : List<GasPriceApiModelMessage>.from(
                json["message"].map((x) => GasPriceApiModelMessage.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toMap())),
      };
}

class GasPriceApiModelMessage {
  GasPriceApiModelMessage({
    required this.id,
    required this.name,
    required this.cost,
    required this.price,
    required this.gallon,
  });

  int id;
  String name;
  String cost;
  String price;
  String gallon;

  factory GasPriceApiModelMessage.fromMap(Map<String, dynamic> json) =>
      GasPriceApiModelMessage(
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"] == null ? '' : json["name"],
        cost: json["cost"] == null ? '0.0' : json["cost"],
        price: json["price"] == null ? '0.0' : json["price"],
        gallon: json["gallon"] == null ? '' : json["gallon"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "cost": cost == null ? null : cost,
        "price": price == null ? null : price,
        "gallon": gallon == null ? null : gallon,
      };
}
