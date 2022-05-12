// To parse this JSON data, do
//
//     final mixAndMatch = mixAndMatchFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MixAndMatch mixAndMatchFromMap(String str) => MixAndMatch.fromMap(json.decode(str));

String mixAndMatchToMap(MixAndMatch data) => json.encode(data.toMap());

class MixAndMatch {
  MixAndMatch({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<MixMatchDatum>? data;

  factory MixAndMatch.fromMap(Map<String, dynamic> json) => MixAndMatch(
    code: json["code"] == null ? 0 : json["code"],
    message: json["message"] == null ? '' : json["message"],
    data: json["data"] == null ? [] : List<MixMatchDatum>.from(json["data"].map((x) => MixMatchDatum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class

MixMatchDatum {
  MixMatchDatum({
    required this.id,
    required this.businessId,
    required this.locationId,
    required this.name,
    required this.type,
    required this.quantity,
    required this.discount,
    required this.taxCategory,
    required this.serviceTypes,
    required this.limitedDates,
    required this.limitedDatesStart,
    required this.limitedDatesEnd,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.timeRestricted,
    required this.timeRestrictedStart,
    required this.timeRestrictedEnd,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.batchId,
    required this.showProduct,
    required this.groupables,
  });

  int id;
  int businessId;
  String locationId;
  String name;
  String type;
  String quantity;
  String discount;
  String taxCategory;
  String serviceTypes;
  int limitedDates;
  DateTime? limitedDatesStart;
  DateTime? limitedDatesEnd;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  int saturday;
  int sunday;
  int timeRestricted;
  DateTime? timeRestrictedStart;
  DateTime? timeRestrictedEnd;
  int isActive;
  int createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int batchId;
  int showProduct;
  List<Groupable>? groupables;

  factory MixMatchDatum.fromMap(Map<String, dynamic> json) => MixMatchDatum(
    id: json["id"] == null ? 0 : json["id"],
    businessId: json["business_id"] == null ? 0 : json["business_id"],
    locationId: json["location_id"] == null ? '' : json["location_id"],
    name: json["name"] == null ? '' : json["name"],
    type: json["type"] == null ? '' : json["type"],
    quantity: json["quantity"] == null ? '' : json["quantity"],
    discount: json["discount"] == null ? '' : json["discount"],
    taxCategory: json["tax_category"] == null ? '' : json["tax_category"],
    serviceTypes: json["service_types"] == null ? '' : json["service_types"],
    limitedDates: json["limited_dates"] == null ? 0 : json["limited_dates"],
    limitedDatesStart: json["limited_dates_start"] == null ? DateTime.now() : DateTime.parse(json["limited_dates_start"]),
    limitedDatesEnd: json["limited_dates_end"] == null ? DateTime.now() : DateTime.parse(json["limited_dates_end"]),
    monday: json["monday"] == null ? 0 : json["monday"],
    tuesday: json["tuesday"] == null ? 0 : json["tuesday"],
    wednesday: json["wednesday"] == null ? 0 : json["wednesday"],
    thursday: json["thursday"] == null ? 0 : json["thursday"],
    friday: json["friday"] == null ? 0 : json["friday"],
    saturday: json["saturday"] == null ? 0 : json["saturday"],
    sunday: json["sunday"] == null ? 0 : json["sunday"],
    timeRestricted: json["time_restricted"] == null ? 0 : json["time_restricted"],
    timeRestrictedStart: json["time_restricted_start"] == null ? DateTime.now() : DateTime.parse(json["time_restricted_start"]),
    timeRestrictedEnd: json["time_restricted_end"] == null ? DateTime.now() : DateTime.parse(json["time_restricted_end"]),
    isActive: json["is_active"] == null ? 0 : json["is_active"],
    createdBy: json["created_by"] == null ? 0 : json["created_by"],
    createdAt: json["created_at"] == null ? DateTime.now() : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? DateTime.now() : DateTime.parse(json["updated_at"]),
    batchId: json["batch_id"] == null ? 0 : json["batch_id"],
    showProduct: json["show_product"] == null ? 0 : json["show_product"],
    groupables: json["groupables"] == null ? [] : List<Groupable>.from(json["groupables"].map((x) => Groupable.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "business_id": businessId == null ? null : businessId,
    "location_id": locationId == null ? null : locationId,
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "quantity": quantity == null ? null : quantity,
    "discount": discount == null ? null : discount,
    "tax_category": taxCategory == null ? null : taxCategory,
    "service_types": serviceTypes == null ? null : serviceTypes,
    "limited_dates": limitedDates == null ? null : limitedDates,
    "limited_dates_start": limitedDatesStart == null ? null : limitedDatesStart!.toIso8601String(),
    "limited_dates_end": limitedDatesEnd == null ? null : limitedDatesEnd!.toIso8601String(),
    "monday": monday == null ? null : monday,
    "tuesday": tuesday == null ? null : tuesday,
    "wednesday": wednesday == null ? null : wednesday,
    "thursday": thursday == null ? null : thursday,
    "friday": friday == null ? null : friday,
    "saturday": saturday == null ? null : saturday,
    "sunday": sunday == null ? null : sunday,
    "time_restricted": timeRestricted == null ? null : timeRestricted,
    "time_restricted_start": timeRestrictedStart == null ? null : timeRestrictedStart!.toIso8601String(),
    "time_restricted_end": timeRestrictedEnd == null ? null : timeRestrictedEnd!.toIso8601String(),
    "is_active": isActive == null ? null : isActive,
    "created_by": createdBy == null ? null : createdBy,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "batch_id": batchId == null ? null : batchId,
    "show_product": showProduct == null ? null : showProduct,
    "groupables": groupables == null ? null : List<dynamic>.from(groupables!.map((x) => x.toMap())),
  };
}

class Groupable {
  Groupable({
    required this.id,
    required this.imageUrl,
    required this.pivot,
  });

  int id;
  String imageUrl;
  Pivot? pivot;

  factory Groupable.fromMap(Map<String, dynamic> json) => Groupable(
    id: json["id"] == null ? 0 : json["id"],
    imageUrl: json["image_url"] == null ? '' : json["image_url"],
    pivot: json["pivot"] == null ? Pivot(groupableId: 0, productId: 0, groupableType: '') : Pivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "image_url": imageUrl == null ? null : imageUrl,
    "pivot": pivot == null ? null : pivot!.toMap(),
  };
}

class Pivot {
  Pivot({
    required this.groupableId,
    required this.productId,
    required this.groupableType,
  });

  int groupableId;
  int productId;
  String groupableType;

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
    groupableId: json["groupable_id"] == null ? 0 : json["groupable_id"],
    productId: json["product_id"] == null ? 0 : json["product_id"],
    groupableType: json["groupable_type"] == null ? '' : json["groupable_type"],
  );

  Map<String, dynamic> toMap() => {
    "groupable_id": groupableId == null ? null : groupableId,
    "product_id": productId == null ? null : productId,
    "groupable_type": groupableType == null ? null : groupableType,
  };
}