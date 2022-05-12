// To parse this JSON data, do
//
//     final searchDepartmentModel = searchDepartmentModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchDepartmentModel searchDepartmentModelFromMap(String str) =>
    SearchDepartmentModel.fromMap(json.decode(str));

String searchDepartmentModelToMap(SearchDepartmentModel data) =>
    json.encode(data.toMap());

class SearchDepartmentModel {
  SearchDepartmentModel({
    required this.code,
    required this.message,
  });

  int code;
  List<SearchDepartmentMessage>? message;

  factory SearchDepartmentModel.fromMap(Map<String, dynamic> json) =>
      SearchDepartmentModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null
            ? []
            : List<SearchDepartmentMessage>.from(
                json["message"].map((x) => SearchDepartmentMessage.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null
            ? null
            : List<dynamic>.from(message!.map((x) => x.toMap())),
      };
}

class SearchDepartmentMessage {
  SearchDepartmentMessage({
    required this.id,
    required this.name,
    required this.businessId,
    required this.shortCode,
    required this.parentId,
    required this.createdBy,
    required this.woocommerceCatId,
    required this.categoryType,
    required this.description,
    required this.slug,
    required this.isAgeRestricted,
    required this.ageRestricted,
    required this.isReconciled,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.batchId,
    required this.isReportDisplay,
  });

  int id;
  String name;
  int businessId;
  dynamic shortCode;
  int parentId;
  int createdBy;
  dynamic woocommerceCatId;
  String categoryType;
  dynamic description;
  dynamic slug;
  int isAgeRestricted;
  int ageRestricted;
  int isReconciled;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic batchId;
  int isReportDisplay;

  factory SearchDepartmentMessage.fromMap(Map<String, dynamic> json) =>
      SearchDepartmentMessage(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        businessId: json["business_id"] == null ? null : json["business_id"],
        shortCode: json["short_code"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        woocommerceCatId: json["woocommerce_cat_id"],
        categoryType:
            json["category_type"] == null ? null : json["category_type"],
        description: json["description"],
        slug: json["slug"],
        isAgeRestricted: json["is_age_restricted"] == null
            ? null
            : json["is_age_restricted"],
        ageRestricted:
            json["age_restricted"] == null ? null : json["age_restricted"],
        isReconciled:
            json["is_reconciled"] == null ? null : json["is_reconciled"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        batchId: json["batch_id"],
        isReportDisplay: json["is_report_display"] == null
            ? null
            : json["is_report_display"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "business_id": businessId == null ? null : businessId,
        "short_code": shortCode,
        "parent_id": parentId == null ? null : parentId,
        "created_by": createdBy == null ? null : createdBy,
        "woocommerce_cat_id": woocommerceCatId,
        "category_type": categoryType == null ? null : categoryType,
        "description": description,
        "slug": slug,
        "is_age_restricted": isAgeRestricted == null ? null : isAgeRestricted,
        "age_restricted": ageRestricted == null ? null : ageRestricted,
        "is_reconciled": isReconciled == null ? null : isReconciled,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "batch_id": batchId,
        "is_report_display": isReportDisplay == null ? null : isReportDisplay,
      };
}
