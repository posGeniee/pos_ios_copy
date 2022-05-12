// To parse this JSON data, do
//
//     final purchaseBulkScan = purchaseBulkScanFromMap(jsonString);

import 'dart:convert';

PurchaseBulkScan purchaseBulkScanFromMap(String str) =>
    PurchaseBulkScan.fromMap(json.decode(str));

String purchaseBulkScanToMap(PurchaseBulkScan data) =>
    json.encode(data.toMap());

class PurchaseBulkScan {
  PurchaseBulkScan({
    required this.code,
    required this.message,
  });

  int code;
  PurchaseBulkScanMessage? message;

  factory PurchaseBulkScan.fromMap(Map<String, dynamic> json) =>
      PurchaseBulkScan(
        code: json["code"] == null ? null.toString() : json["code"],
        message: json["message"] == null
            ? PurchaseBulkScanMessage(
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
            : PurchaseBulkScanMessage.fromMap(json["message"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null.toString() : code,
        "message": message == null ? null.toString() : message!.toMap(),
      };
}

class PurchaseBulkScanMessage {
  PurchaseBulkScanMessage({
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
  List<PurchaseBulkScanDatum>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<PurchaseBulkScanLink>? links;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory PurchaseBulkScanMessage.fromMap(Map<String, dynamic> json) =>
      PurchaseBulkScanMessage(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? null
            : List<PurchaseBulkScanDatum>.from(
                json["data"].map((x) => PurchaseBulkScanDatum.fromMap(x))),
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
            : List<PurchaseBulkScanLink>.from(
                json["links"].map((x) => PurchaseBulkScanLink.fromMap(x))),
        nextPageUrl: json["next_page_url"] == null
            ? null.toString()
            : json["next_page_url"],
        path: json["path"] == null ? null.toString() : json["path"],
        perPage: json["per_page"] == null ? null.toString() : json["per_page"],
        prevPageUrl: json["prev_page_url"],
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
        "next_page_url": nextPageUrl == null ? null.toString() : nextPageUrl,
        "path": path == null ? null.toString() : path,
        "per_page": perPage == null ? null.toString() : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null.toString() : to,
        "total": total == null ? null.toString() : total,
      };
}

class PurchaseBulkScanDatum {
  PurchaseBulkScanDatum({
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
    required this.qtyAvailable,
    required this.packSize,
    required this.packPrice,
    required this.packUpc,
    required this.vendorId,
    required this.caseSize,
    required this.variationId,
    required this.purchaseLineId,
    required this.caseCost,
    required this.plu,
    required this.unitCost,
    required this.newRetailPrice,
    required this.itemId,
    required this.packageUPC,
    required this.wicEligible,
    required this.unitId,
    required this.subunitId,
    required this.activeItem,
    required this.purchaseLineTaxId,
    required this.orderUnit,
    required this.orderCase,
    required this.extCost,
    required this.profitMargin,
    required this.caseMargin,
    required this.caseRetial,
    required this.departmentId,
    required this.stockOfProduct,
  });

  int id;
  String productCode;
  String proName;
  String sku;
  String image;
  String taxNumber;
  int ebt;
  int cateId;
  String cateName;
  String price;
  String cost;
  String margin;
  String onHandQty;
  String qtyAvailable;
  String packSize;
  String packPrice;
  String packUpc;
  String vendorId;
  String caseSize;
  int variationId;
  int purchaseLineId;
  String caseCost;
  String plu;
  String unitCost;
  String newRetailPrice;
  String itemId;
  String packageUPC;
  String wicEligible;
  String unitId;
  String subunitId;
  String activeItem;
  String purchaseLineTaxId;
  String orderUnit;
  String orderCase;
  String extCost;
  String profitMargin;
  String caseMargin;
  String caseRetial;
  String departmentId;
  String stockOfProduct;

  factory PurchaseBulkScanDatum.fromMap(Map<String, dynamic> json) =>
      PurchaseBulkScanDatum(
        id: json["id"] == null ? '' : json["id"],
        productCode: json["product_code"] == null ? '' : json["product_code"],
        proName: json["pro_name"] == null ? '' : json["pro_name"],
        sku: json["sku"] == null ? '' : json["sku"],
        image: json["image"] == null ? '' : json["image"],
        taxNumber: json["tax_number"] == null ? '' : json["tax_number"],
        ebt: json["EBT"] == null ? '' : json["EBT"],
        cateId: json["cate_id"] == null ? '' : json["cate_id"],
        cateName: json["cate_name"] == null ? '' : json["cate_name"],
        price: json["price"] == null ? '' : json["price"],
        cost: json["cost"] == null ? '0.0' : json["cost"],
        margin: json["margin"] == null ? '' : json["margin"],
        onHandQty: json["on_hand_qty"] == null ? '' : json["on_hand_qty"],
        qtyAvailable:
            json["qty_available"] == null ? '' : json["qty_available"],
        packSize: json["pack_size"] == null ? '' : json["pack_size"],
        packPrice: json["pack_price"] == null ? '' : json["pack_price"],
        packUpc: json["pack_upc"] == null ? '' : json["pack_upc"],
        caseCost: json["case_cost"] == null ? '' : json["case_cost"],
        vendorId:
            json["vendor_id"] == null ? '0.0' : json["vendor_id"].toString(),
        caseSize: json["case_size"] == null ? '1.0' : json["case_size"],
        variationId: json["variation_id"] == null ? '' : json["variation_id"],
        purchaseLineId:
            json["purchase_line_id"] == null ? '' : json["purchase_line_id"],
        plu: json["plu"] == null ? '' : json["plu"].toString(),
        unitCost: json["unit_cost"] == null ? '0.0' : json["unit_cost"],
        newRetailPrice:
            json["retail_price"] == null ? '' : json["retail_price"],
        itemId: json["item"] == null ? '' : json["item"],
        packageUPC: json["item_upc"] == null ? '' : json["item_upc"],
        wicEligible:
            json["wic_eligible"] == null ? '' : json["wic_eligible"].toString(),
        unitId: json["unit_id"] == null ? '' : json["unit_id"].toString(),
        subunitId:
            json["sub_unit_ids"] == null ? '' : json["sub_unit_ids"].toString(),
        activeItem:
            json["active_item"] == null ? '' : json["active_item"].toString(),
        purchaseLineTaxId: json["purchase_line_tax_id"] == null
            ? ''
            : json["purchase_line_tax_id"].toString(),
        orderUnit:
            json["order_unit"] == null ? "1.0" : json["order_unit"].toString(),
        orderCase:
            json["order_case"] == null ? "1.0" : json["order_case"].toString(),
        extCost: json["extCost"] == null ? "1.0" : json["extCost"].toString(),
        profitMargin: json["profitMargin"] == null
            ? "0.0"
            : json["profitMargin"].toString(),
        caseMargin:
            json["caseMargin"] == null ? "0.0" : json["caseMargin"].toString(),
        caseRetial:
            json["caseRetail"] == null ? "0.0" : json["caseRetail"].toString(),
        departmentId: json["departmentId"] == null
            ? "0.0"
            : json["departmentId"].toString(),
        stockOfProduct: json["enable_stock"] == null
            ? '0.0'
            : json["enable_stock"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? '' : id,
        "product_code": productCode == null ? '' : productCode,
        "pro_name": proName == null ? '' : proName,
        "sku": sku == null ? '' : sku,
        "image": image == null ? '' : image,
        "tax_number": taxNumber == null ? '' : taxNumber,
        "EBT": ebt == null ? '' : ebt,
        "cate_id": cateId == null ? '' : cateId,
        "cate_name": cateName == null ? '' : cateName,
        "price": price == null ? '' : price,
        "cost": cost == null ? '' : cost,
        "margin": margin == null ? '' : margin,
        "on_hand_qty": onHandQty == null ? '' : onHandQty,
        "qty_available": qtyAvailable == null ? '' : qtyAvailable,
        "pack_size": packSize == null ? '' : packSize,
        "pack_price": packPrice == null ? '' : packPrice,
        "pack_upc": packUpc == null ? '' : packUpc,
        "vendor_id": vendorId == null ? '' : vendorId,
        "case_size": caseSize == null ? '1.0' : caseSize,
        "variation_id": variationId == null ? '' : variationId,
        "purchase_line_id": purchaseLineId == null ? '' : purchaseLineId,
        "case_cost": caseCost == null ? '0.0' : caseCost,
        "unit_cost": unitCost == null ? '0.0' : unitCost,
        "retail_price": newRetailPrice == null ? '0.0' : newRetailPrice,
        "item_upc": packageUPC == null ? '0.0' : packageUPC,
        "wic_eligible": wicEligible == null ? '0.0' : wicEligible,
      };
}

class PurchaseBulkScanLink {
  PurchaseBulkScanLink({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory PurchaseBulkScanLink.fromMap(Map<String, dynamic> json) =>
      PurchaseBulkScanLink(
        url: json["url"] == null ? '' : json["url"],
        label: json["label"] == null ? '' : json["label"],
        active: json["active"] == null ? '' : json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? '' : url,
        "label": label == null ? '' : label,
        "active": active == null ? '' : active,
      };
}
