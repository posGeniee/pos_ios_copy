// To parse this JSON data, do
//
//     final searchProductsWithPluGroupMixMatchModel = searchProductsWithPluGroupMixMatchModelFromMap(jsonString);

import 'dart:convert';

SearchProductsWithPluGroupMixMatchModel
    searchProductsWithPluGroupMixMatchModelFromMap(String str) =>
        SearchProductsWithPluGroupMixMatchModel.fromMap(json.decode(str));

String searchProductsWithPluGroupMixMatchModelToMap(
        SearchProductsWithPluGroupMixMatchModel data) =>
    json.encode(data.toMap());

class SearchProductsWithPluGroupMixMatchModel {
  SearchProductsWithPluGroupMixMatchModel({
    required this.code,
    required this.message,
  });

  int code;
  MessageSearchProductsWithPluGroupMixMatch? message;

  factory SearchProductsWithPluGroupMixMatchModel.fromMap(
          Map<String, dynamic> json) =>
      SearchProductsWithPluGroupMixMatchModel(
        code: json["code"] == null ? null.toString() : json["code"],
        message: json["message"] == null
            ? MessageSearchProductsWithPluGroupMixMatch(
                currentPage: 0,
                data: [],
                firstPageUrl: '',
                from: 0,
                lastPage: 0,
                lastPageUrl: '',
                links: [],
                nextPageUrl: '',
                path: '',
                perPage: 0,
                prevPageUrl: '',
                to: 0,
                total: 0)
            : MessageSearchProductsWithPluGroupMixMatch.fromMap(
                json["message"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null.toString() : code,
        "message": message == null ? null.toString() : message!.toMap(),
      };
}

class MessageSearchProductsWithPluGroupMixMatch {
  MessageSearchProductsWithPluGroupMixMatch({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<DatumSearchProductsWithPluGroupMixMatch>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<LinkSearchProductsWithPluGroupMixMatch>? links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory MessageSearchProductsWithPluGroupMixMatch.fromMap(
          Map<String, dynamic> json) =>
      MessageSearchProductsWithPluGroupMixMatch(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? null
            : List<DatumSearchProductsWithPluGroupMixMatch>.from(json["data"]
                .map(
                    (x) => DatumSearchProductsWithPluGroupMixMatch.fromMap(x))),
        firstPageUrl: json["first_page_url"] == null
            ? null.toString()
            : json["first_page_url"],
        from: json["from"] == null ? 0 : json["from"],
        lastPage: json["last_page"] == null ? 0 : json["last_page"],
        lastPageUrl: json["last_page_url"] == null
            ? null.toString()
            : json["last_page_url"],
        links: json["links"] == null
            ? null
            : List<LinkSearchProductsWithPluGroupMixMatch>.from(json["links"]
                .map((x) => LinkSearchProductsWithPluGroupMixMatch.fromMap(x))),
        nextPageUrl: json["next_page_url"] == null ? 0 : json["next_page_url"],
        path: json["path"] == null ? null.toString() : json["path"],
        perPage: json["per_page"] == null ? 0 : json["per_page"],
        prevPageUrl: json["prev_page_url"] == null ? 0 : json["prev_page_url"],
        to: json["to"] == null ? 0 : json["to"],
        total: json["total"] == null ? 0 : json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage == null ? null.toString() : currentPage,
        "data": data == null
            ? null.toString()
            : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl == null ? null.toString() : firstPageUrl,
        "from": from == null ? null.toString() : from,
        "last_page": lastPage == null ? null.toString() : lastPage,
        "last_page_url": lastPageUrl == null ? null.toString() : lastPageUrl,
        "links": links == null
            ? null.toString()
            : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path == null ? null.toString() : path,
        "per_page": perPage == null ? null.toString() : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null.toString() : to,
        "total": total == null ? null.toString() : total,
      };
}

class DatumSearchProductsWithPluGroupMixMatch {
  DatumSearchProductsWithPluGroupMixMatch({
    required this.id,
    required this.productCode,
    required this.proName,
    required this.sku,
    required this.image,
    required this.taxNumber,
    required this.ebt,
    required this.cateId,
    required this.cateName,
    required this.price,
    required this.cost,
    required this.margin,
    required this.onHandQty,
    required this.packSize,
    required this.packPrice,
    required this.packUpc,
    required this.vendorId,
  });

  int id;
  String productCode;
  String proName;
  String sku;
  dynamic image;
  String taxNumber;
  int ebt;
  int cateId;
  String cateName;
  String price;
  String cost;
  String margin;
  String onHandQty;
  dynamic packSize;
  String packPrice;
  dynamic packUpc;
  dynamic vendorId;

  factory DatumSearchProductsWithPluGroupMixMatch.fromMap(
          Map<String, dynamic> json) =>
      DatumSearchProductsWithPluGroupMixMatch(
        id: json["id"] == null ? 0 : json["id"],
        productCode: json["product_code"] == null
            ? null.toString()
            : json["product_code"],
        proName: json["pro_name"] == null ? null.toString() : json["pro_name"],
        sku: json["sku"] == null ? null.toString() : json["sku"],
        image: json["image"],
        taxNumber:
            json["tax_number"] == null ? null.toString() : json["tax_number"],
        ebt: json["EBT"] == null ? 0 : json["EBT"],
        cateId: json["cate_id"] == null ? 0 : json["cate_id"],
        cateName:
            json["cate_name"] == null ? null.toString() : json["cate_name"],
        price: json["price"] == null ? null.toString() : json["price"],
        cost: json["cost"] == null ? null.toString() : json["cost"],
        margin: json["margin"] == null ? null.toString() : json["margin"],
        onHandQty:
            json["on_hand_qty"] == null ? null.toString() : json["on_hand_qty"],
        packPrice:
            json["pack_price"] == null ? null.toString() : json["pack_price"],
        packUpc: json["pack_upc"],
        vendorId: json["vendor_id"],
        packSize:
            json["pack_size"] == null ? null.toString() : json["pack_size"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null.toString() : id,
        "product_code": productCode == null ? null.toString() : productCode,
        "pro_name": proName == null ? null.toString() : proName,
        "sku": sku == null ? null.toString() : sku,
        "image": image,
        "tax_number": taxNumber == null ? null.toString() : taxNumber,
        "EBT": ebt == null ? null.toString() : ebt,
        "cate_id": cateId == null ? null.toString() : cateId,
        "cate_name": cateName == null ? null.toString() : cateName,
        "price": price == null ? null.toString() : price,
        "cost": cost == null ? null.toString() : cost,
        "margin": margin == null ? null.toString() : margin,
        "on_hand_qty": onHandQty == null ? null.toString() : onHandQty,
        "pack_size": packSize,
        "pack_price": packPrice == null ? null.toString() : packPrice,
        "pack_upc": packUpc,
        "vendor_id": vendorId,
      };
}

class LinkSearchProductsWithPluGroupMixMatch {
  LinkSearchProductsWithPluGroupMixMatch({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory LinkSearchProductsWithPluGroupMixMatch.fromMap(
          Map<String, dynamic> json) =>
      LinkSearchProductsWithPluGroupMixMatch(
        url: json["url"] == null ? null.toString() : json["url"],
        label: json["label"] == null ? null.toString() : json["label"],
        active: json["active"] == null ? true : json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? null.toString() : url,
        "label": label == null ? null.toString() : label,
        "active": active == null ? null.toString() : active,
      };
}
