// To parse this JSON data, do
//
//     final customerListModel = customerListModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CustomerListModel customerListModelFromMap(String str) => CustomerListModel.fromMap(json.decode(str));

String customerListModelToMap(CustomerListModel data) => json.encode(data.toMap());

class CustomerListModel {
  CustomerListModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<Datum>? data;

  factory CustomerListModel.fromMap(Map<String, dynamic> json) => CustomerListModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.customerGroupId,
    required this.businessId,
    required this.type,
    required this.name,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.contactId,
    required this.dob,
    required this.mobile,
    required this.balance,
    required this.visitsCount,
    required this.usedLoyaltyPoint,
    required this.creditLimit,
  });

  int id;
  int customerGroupId;
  int businessId;
  String type;
  String name;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String contactId;
  DateTime? dob;
  String mobile;
  String balance;
  int visitsCount;
  String usedLoyaltyPoint;
  String creditLimit;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    customerGroupId: json["customer_group_id"] == null ? 0 : json["customer_group_id"],
    businessId: json["business_id"] == null ? null : json["business_id"],
    type: json["type"] == null ? null : json["type"],
    name: json["name"] == null ? '' : json["name"],
    firstName: json["first_name"] == null ? '' : json["first_name"],
    middleName: json["middle_name"] == null ? '' : json["middle_name"],
    lastName: json["last_name"] == null ? '' : json["last_name"],
    email: json["email"] == null ? '' : json["email"],
    contactId: json["contact_id"] == '' ? null : json["contact_id"],
    dob: json["dob"] == null ? DateTime.now() : DateTime.parse(json["dob"]),
    mobile: json["mobile"] == null ? '' : json["mobile"],
    balance: json["balance"] == null ? '' : json["balance"],
    visitsCount: json["visits_count"] == null ? 0 : json["visits_count"],
    usedLoyaltyPoint: json["used_loyalty_point"] == null ? '0.0' : json["used_loyalty_point"],
    creditLimit: json["credit_limit"] == null ? '' : json["credit_limit"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "customer_group_id": customerGroupId == null ? null : customerGroupId,
    "business_id": businessId == null ? null : businessId,
    "type": type == null ? null : type,
    "name": name == null ? null : name,
    "first_name": firstName == null ? null : firstName,
    "middle_name": middleName == null ? null : middleName,
    "last_name": lastName == null ? null : lastName,
    "email": email == null ? null : email,
    "contact_id": contactId == null ? null : contactId,
    "dob": dob == null ? null : "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "mobile": mobile == null ? null : mobile,
    "balance": balance == null ? null : balance,
    "visits_count": visitsCount == null ? null : visitsCount,
    "used_loyalty_point": usedLoyaltyPoint == null ? null : usedLoyaltyPoint,
    "credit_limit": creditLimit == null ? null : creditLimit,
  };
}
