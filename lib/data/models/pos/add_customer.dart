// To parse this JSON data, do
//
//     final addCustomerModel = addCustomerModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddCustomerModel addCustomerModelFromMap(String str) => AddCustomerModel.fromMap(json.decode(str));

String addCustomerModelToMap(AddCustomerModel data) => json.encode(data.toMap());

class AddCustomerModel {
  AddCustomerModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<AddCustomerDatum>? data;

  factory AddCustomerModel.fromMap(Map<String, dynamic> json) => AddCustomerModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<AddCustomerDatum>.from(json["data"].map((x) => AddCustomerDatum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class AddCustomerDatum {
  AddCustomerDatum({
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
    required this.creditLimit,
    required this.offlineId,
    required this.terminalId,
    required this.zipCode,
  });

  int id;
  int customerGroupId;
  int businessId;
  String type;
  String name;
  String firstName;
  dynamic middleName;
  dynamic lastName;
  String email;
  String contactId;
  dynamic dob;
  String mobile;
  String balance;
  int visitsCount;
  dynamic creditLimit;
  int offlineId;
  int terminalId;
  String zipCode;

  factory AddCustomerDatum.fromMap(Map<String, dynamic> json) => AddCustomerDatum(
    id: json["id"] == null ? 0 : json["id"],
    customerGroupId: json["customer_group_id"] == null ? 0 : json["customer_group_id"],
    businessId: json["business_id"] == null ? 0 : json["business_id"],
    type: json["type"] == null ? '' : json["type"],
    name: json["name"] == null ? '' : json["name"],
    firstName: json["first_name"] == null ? '' : json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    email: json["email"] == null ? '' : json["email"],
    contactId: json["contact_id"] == null ? '' : json["contact_id"],
    dob: json["dob"],
    mobile: json["mobile"] == null ? '' : json["mobile"],
    balance: json["balance"] == null ? '' : json["balance"],
    visitsCount: json["visits_count"] == null ? 0 : json["visits_count"],
    creditLimit: json["credit_limit"],
    offlineId: json["offline_id"] == null ? 0 : json["offline_id"],
    terminalId: json["terminal_id"] == null ? 0 : json["terminal_id"],
    zipCode: json["zip_code"] == null ? '' : json["zip_code"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "customer_group_id": customerGroupId == null ? null : customerGroupId,
    "business_id": businessId == null ? null : businessId,
    "type": type == null ? null : type,
    "name": name == null ? null : name,
    "first_name": firstName == null ? null : firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "email": email == null ? null : email,
    "contact_id": contactId == null ? null : contactId,
    "dob": dob,
    "mobile": mobile == null ? null : mobile,
    "balance": balance == null ? null : balance,
    "visits_count": visitsCount == null ? null : visitsCount,
    "credit_limit": creditLimit,
    "offline_id": offlineId == null ? null : offlineId,
    "terminal_id": terminalId == null ? null : terminalId,
    "zip_code": zipCode == null ? null : zipCode,
  };
}
