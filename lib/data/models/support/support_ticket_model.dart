// To parse this JSON data, do
//
//     final receiptModel = receiptModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SupportModel supportModelFromJson(String str) =>
    SupportModel.fromJson(json.decode(str));

String supportModelToJson(SupportModel data) => json.encode(data.toJson());

class SupportModel {
  SupportModel({
    required this.code,
    required this.message,
  });

  int code;
  List<Message> message;

  factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
        code: json["code"] == null ? 0 : json["code"],
        message: json["message"] == null
            ? []
            : List<Message>.from(
                json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null
            ? null
            : List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    required this.id,
    required this.businessId,
    required this.locationId,
    required this.ticket,
    required this.name,
    required this.email,
    required this.subject,
    required this.priority,
    required this.message,
    required this.image,
    required this.terminalId,
    required this.offlineId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.serviceName,
    required this.imageUrl,
    required this.createdByUser,
  });

  int id;
  int businessId;
  String locationId;
  String ticket;
  String name;
  String email;
  String subject;
  String priority;
  String message;
  String image;
  dynamic terminalId;
  dynamic offlineId;
  int createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  String serviceName;
  String imageUrl;
  CreatedByUser createdByUser;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] == null ? 0 : json["id"],
        businessId: json["business_id"] == null ? 0 : json["business_id"],
        locationId: json["location_id"] == null ? "" : json["location_id"],
        ticket: json["ticket"] == null ? "" : json["ticket"],
        name: json["name"] == null ? "" : json["name"],
        email: json["email"] == null ? "" : json["email"],
        subject: json["subject"] == null ? "" : json["subject"],
        priority: json["priority"] == null ? "" : json["priority"],
        message: json["message"] == null ? "" : json["message"],
        image: json["image"] == null ? "" : json["image"],
        terminalId: json["terminal_id"] == null ? "" : json["terminal_id"],
        // json["terminal_id"],
        offlineId: json["offline_id"] == null ? "" : json["offline_id"],

        createdBy: json["created_by"] == null ? 0 : json["created_by"],
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        status: json["status"] == null ? '' : json["status"],
        serviceName: json["service_name"] == null ? '' : json["service_name"],
        imageUrl: json["image_url"] == null
            ? 'https://cdnimg.webstaurantstore.com/images/products/large/527588/1949106.jpg'
            : json["image_url"],
        createdByUser: json["created_by_user"] == null
            ? CreatedByUser(
                id: 0,
                username: '',
                email: '',
                businessId: 0,
                business: Business(id: 0, name: ''),
              )
            : CreatedByUser.fromJson(json["created_by_user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? 0 : id,
        "business_id": businessId == null ? null : businessId,
        "location_id": locationId == null ? null : locationId,
        "ticket": ticket == null ? null : ticket,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "subject": subject == null ? null : subject,
        "priority": priority == null ? null : priority,
        "message": message == null ? null : message,
        "image": image == null ? null : image,
        "terminal_id": terminalId,
        "offline_id": offlineId,
        "created_by": createdBy == null ? null : createdBy,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "status": status == null ? null : status,
        "service_name": serviceName == null ? null : serviceName,
        "image_url": imageUrl == null ? null : imageUrl,
        "created_by_user":
            createdByUser == null ? null : createdByUser.toJson(),
      };
}

class CreatedByUser {
  CreatedByUser({
    required this.id,
    required this.username,
    required this.email,
    required this.businessId,
    required this.business,
  });

  int id;
  String username;
  String email;
  int businessId;
  Business business;

  factory CreatedByUser.fromJson(Map<String, dynamic> json) => CreatedByUser(
        id: json["id"] == null ? 0 : json["id"],
        username: json["username"] == null ? '' : json["username"],
        email: json["email"] == null ? '' : json["email"],
        businessId: json["business_id"] == null ? 0 : json["business_id"],
        business: json["business"] == null
            ? Business(id: 0, name: '')
            : Business.fromJson(json["business"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "business_id": businessId == null ? null : businessId,
        "business":
            business == null ? Business(id: 0, name: '') : business.toJson(),
      };
}

class Business {
  Business({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"] == null ? '' : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
