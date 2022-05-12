// To parse this JSON data, do
//
//     final searchResultByBarCodeOrNameModel = searchResultByBarCodeOrNameModelFromMap(jsonString);

import 'dart:convert';

SearchResultByBarCodeOrNameModel searchResultByBarCodeOrNameModelFromMap(
        String str) =>
    SearchResultByBarCodeOrNameModel.fromMap(json.decode(str));

String searchResultByBarCodeOrNameModelToMap(
        SearchResultByBarCodeOrNameModel data) =>
    json.encode(data.toMap());

class SearchResultByBarCodeOrNameModel {
  SearchResultByBarCodeOrNameModel({
    required this.code,
    required this.message,
  });

  int code;
  MessageSearchResultByBarCodeOrName? message;

  factory SearchResultByBarCodeOrNameModel.fromMap(Map<String, dynamic> json) =>
      SearchResultByBarCodeOrNameModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null
            ? MessageSearchResultByBarCodeOrName(
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
            : MessageSearchResultByBarCodeOrName.fromMap(json["message"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message!.toMap(),
      };
}

class MessageSearchResultByBarCodeOrName {
  MessageSearchResultByBarCodeOrName({
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
  List<DatumSearchResultByBarCodeOrName>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<LinkSearchResultByBarCodeOrName>? links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory MessageSearchResultByBarCodeOrName.fromMap(
          Map<String, dynamic> json) =>
      MessageSearchResultByBarCodeOrName(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<DatumSearchResultByBarCodeOrName>.from(json["data"]
                .map((x) => DatumSearchResultByBarCodeOrName.fromMap(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        links: json["links"] == null
            ? null
            : List<LinkSearchResultByBarCodeOrName>.from(json["links"]
                .map((x) => LinkSearchResultByBarCodeOrName.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class DatumSearchResultByBarCodeOrName {
  DatumSearchResultByBarCodeOrName({
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
    required this.caseSize,
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
  String caseSize;

  factory DatumSearchResultByBarCodeOrName.fromMap(Map<String, dynamic> json) =>
      DatumSearchResultByBarCodeOrName(
        id: json["id"] == null ? null : json["id"],
        productCode: json["product_code"] == null ? null : json["product_code"],
        proName: json["pro_name"] == null ? null : json["pro_name"],
        sku: json["sku"] == null ? null : json["sku"],
        image: json["image"],
        taxNumber: json["tax_number"] == null ? null : json["tax_number"],
        ebt: json["EBT"] == null ? null : json["EBT"],
        cateId: json["cate_id"] == null ? null : json["cate_id"],
        cateName: json["cate_name"] == null ? null : json["cate_name"],
        price: json["price"] == null ? null : json["price"],
        cost: json["cost"] == null ? null : json["cost"],
        margin: json["margin"] == null ? null : json["margin"],
        onHandQty: json["on_hand_qty"] == null ? null : json["on_hand_qty"],
        packSize: json["pack_size"],
        packPrice: json["pack_price"] == null ? null : json["pack_price"],
        packUpc: json["pack_upc"],
        vendorId: json["vendor_id"],
        caseSize: json["case_size"] == null ? null : json["case_size"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "product_code": productCode == null ? null : productCode,
        "pro_name": proName == null ? null : proName,
        "sku": sku == null ? null : sku,
        "image": image,
        "tax_number": taxNumber == null ? null : taxNumber,
        "EBT": ebt == null ? null : ebt,
        "cate_id": cateId == null ? null : cateId,
        "cate_name": cateName == null ? null : cateName,
        "price": price == null ? null : price,
        "cost": cost == null ? null : cost,
        "margin": margin == null ? null : margin,
        "on_hand_qty": onHandQty == null ? null : onHandQty,
        "pack_size": packSize,
        "pack_price": packPrice == null ? null : packPrice,
        "pack_upc": packUpc,
        "vendor_id": vendorId,
        "case_size": caseSize == null ? null : caseSize,
      };
}

class LinkSearchResultByBarCodeOrName {
  LinkSearchResultByBarCodeOrName({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory LinkSearchResultByBarCodeOrName.fromMap(Map<String, dynamic> json) =>
      LinkSearchResultByBarCodeOrName(
        url: json["url"] == null ? null : json["url"],
        label: json["label"] == null ? null : json["label"],
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? null : url,
        "label": label == null ? null : label,
        "active": active == null ? null : active,
      };
}
