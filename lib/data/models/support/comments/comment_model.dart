// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

List<CommentModel> commentModelFromJson(String str) => List<CommentModel>.from(
    json.decode(str).map((x) => CommentModel.fromJson(x)));

String commentModelToJson(List<CommentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentModel {
  CommentModel({
    required this.id,
    required this.supportId,
    required this.type,
    required this.userName,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int supportId;
  String type;
  String userName;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"] == null ? 0 : json["id"],
        supportId: json["support_id"] == null ? 0 : json["support_id"],
        type: json["type"] == null ? '' : json["type"],
        userName: json["user_name"] == null ? '' : json["user_name"],
        comment: json["comment"] == null ? '' : json["comment"],
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "support_id": supportId == null ? null : supportId,
        "type": type == null ? null : type,
        "user_name": userName == null ? null : userName,
        "comment": comment == null ? null : comment,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
