// To parse this JSON data, do
//
//     final businessSettingModel = businessSettingModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BusinessSettingModel businessSettingModelFromMap(String str) => BusinessSettingModel.fromMap(json.decode(str));

String businessSettingModelToMap(BusinessSettingModel data) => json.encode(data.toMap());

class BusinessSettingModel {
  BusinessSettingModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<BusinessSetting>? data;

  factory BusinessSettingModel.fromMap(Map<String, dynamic> json) => BusinessSettingModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<BusinessSetting>.from(json["data"].map((x) => BusinessSetting.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class BusinessSetting {
  BusinessSetting({
    required this.couponAmount,
    required this.maxDrawerAmount,
    required this.taxId,
    required this.taxName,
    required this.taxAmount,
    required this.promotionTime,
    required this.cashbackFee,
    required this.breakTiming,
    required this.loyaltyPoint,
    required this.loyaltyAmount,
  });

  int couponAmount;
  String maxDrawerAmount;
  int taxId;
  String taxName;
  String taxAmount;
  int promotionTime;
  String cashbackFee;
  String breakTiming;
  String loyaltyPoint;
  String loyaltyAmount;

  factory BusinessSetting.fromMap(Map<String, dynamic> json) => BusinessSetting(
    couponAmount: json["coupon_amount"] == null ? 0 : json["coupon_amount"],
    maxDrawerAmount: json["max_drawer_amount"] == null ? '' : json["max_drawer_amount"],
    taxId: json["tax_id"] == null ? 0 : json["tax_id"],
    taxName: json["tax_name"] == null ? '' : json["tax_name"],
    taxAmount: json["tax_amount"] == null ? '' : json["tax_amount"],
    promotionTime: json["promotion_time"] == null ? 0 : json["promotion_time"],
    cashbackFee: json["cashback_fee"] == null ? '' : json["cashback_fee"],
    breakTiming: json["break_timing"] == null ? '' : json["break_timing"],
    loyaltyPoint: json["loyalty_point"] == null ? '' : json["loyalty_point"],
    loyaltyAmount: json["loyalty_amount"] == null ? '' : json["loyalty_amount"],
  );

  Map<String, dynamic> toMap() => {
    "coupon_amount": couponAmount == null ? null : couponAmount,
    "max_drawer_amount": maxDrawerAmount == null ? null : maxDrawerAmount,
    "tax_id": taxId == null ? null : taxId,
    "tax_name": taxName == null ? null : taxName,
    "tax_amount": taxAmount == null ? null : taxAmount,
    "promotion_time": promotionTime == null ? null : promotionTime,
    "cashback_fee": cashbackFee == null ? null : cashbackFee,
    "break_timing": breakTiming == null ? null : breakTiming,
    "loyalty_point": loyaltyPoint == null ? null : loyaltyPoint,
    "loyalty_amount": loyaltyAmount == null ? null : loyaltyAmount,
  };
}
