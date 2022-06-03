import 'package:dummy_app/data/models/sale_summary_model.dart';
import 'dart:convert';

ScanBarCode scanBarCodeFromMap(String str) =>
    ScanBarCode.fromMap(json.decode(str));

String scanBarCodeToMap(ScanBarCode data) => json.encode(data.toMap());

class ScanBarCode {
  ScanBarCode({
    required this.code,
    required this.message,
  });

  int code;
  ScanBarCodeMessage? message;

  factory ScanBarCode.fromMap(Map<String, dynamic> json) => ScanBarCode(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null
            ? ScanBarCodeMessage(
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
            : ScanBarCodeMessage.fromMap(json["message"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message!.toMap(),
      };
}

class ScanBarCodeMessage {
  ScanBarCodeMessage({
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
  List<ScanBarCodeDatum>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory ScanBarCodeMessage.fromMap(Map<String, dynamic> json) =>
      ScanBarCodeMessage(
        currentPage: json["current_page"] == null ? 0 : json["current_page"],
        data: json["data"] == null
            ? null
            : List<ScanBarCodeDatum>.from(
                json["data"].map((x) => ScanBarCodeDatum.fromMap(x))),
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
            : List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"] == null
            ? null.toString()
            : json["next_page_url"],
        // json["next_page_url"],
        path: json["path"] == null ? null.toString() : json["path"],
        perPage: json["per_page"] == null ? null.toString() : json["per_page"],
        prevPageUrl: json["prev_page_url"] == null
            ? null.toString()
            : json["prev_page_url"],
        // json["prev_page_url"],
        to: json["to"] == null ? 0 : json["to"],
        total: json["total"] == null ? 0 : json["total"],
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

class ScanBarCodeDatum {
  ScanBarCodeDatum({
    required this.id,
    required this.productCode,
    required this.proName,
    required this.sku,
    required this.itemUpc,
    required this.item,
    required this.unitCost,
    required this.taxNumber,
    required this.ebt,
    required this.rebateGroup,
    required this.type,
    required this.mixMatchGroup,
    required this.inventoryGroup,
    required this.cateId,
    required this.cateName,
    required this.price,
    required this.cost,
    required this.margin,
    required this.onHandQty,
    required this.qtyAvailable,
    required this.packSize,
    required this.packUpc,
    required this.caseCost,
    required this.vendorId,
    required this.onSpecial,
    required this.startDate,
    required this.endDate,
    required this.plu,
    required this.packPrice,
    required this.retailPrice,
    required this.caseSize,
    required this.specialPrice,
    required this.loyaltyDescription,
    required this.loyaltyPoint,
    required this.weightItem,
    required this.ebtEligible,
    required this.wicEligible,
    required this.activeItem,
    required this.ingredient,
    required this.showInMenu,
    required this.showInKiosk,
    required this.mustAskQty,
    required this.inventory,
    required this.kitchenPrinter,
    required this.loyaltyAmount,
    required this.sendToScale,
    required this.unitId,
    required this.subUnitIds,
    required this.tax,
    required this.taxAmount,
    required this.unitWeight,
    required this.caseWeight,
    required this.variationId,
    required this.purchaseLineId,
    required this.purchaseLineTaxId,
    required this.stockOfProduct,
    required this.subTotal,
    required this.unitQty,
    required this.mixmatchGroupIdApply,
    required this.mixMatchGroupApplied,
    required this.subtotalAfterDiscount,
    required this.discount,
    required this.cartTax,
    required this.ebtCart,
    required this.cartLoyaltyPoints,
  });

  int id;
  String productCode;
  String proName;
  String sku;
  dynamic itemUpc;
  dynamic item;
  String unitCost;
  String taxNumber;
  int ebt;
  dynamic rebateGroup;
  String type;
  dynamic mixMatchGroup;
  dynamic inventoryGroup;
  int cateId;
  String cateName;
  String price;
  String cost;
  String margin;
  String onHandQty;
  String qtyAvailable;
  dynamic packSize;
  dynamic packUpc;
  String caseCost;
  dynamic vendorId;
  int onSpecial;
  dynamic startDate;
  dynamic endDate;
  dynamic plu;
  String packPrice;
  String retailPrice;
  String caseSize;
  String specialPrice;
  dynamic loyaltyDescription;
  String loyaltyPoint;
  int weightItem;
  int ebtEligible;
  int wicEligible;
  int activeItem;
  int ingredient;
  int showInMenu;
  int showInKiosk;
  int mustAskQty;
  int inventory;
  int kitchenPrinter;
  String loyaltyAmount;
  int sendToScale;
  int unitId;
  dynamic subUnitIds;
  String tax;
  dynamic taxAmount;
  String unitWeight;
  String caseWeight;
  int variationId;
  int purchaseLineId;
  dynamic purchaseLineTaxId;
  String stockOfProduct;
  String subTotal;
  String unitQty;
  List<int> mixmatchGroupIdApply;
  bool mixMatchGroupApplied;
  double subtotalAfterDiscount;
  int discount;
  double cartTax;
  double ebtCart;
  double cartLoyaltyPoints;

  factory ScanBarCodeDatum.fromMap(Map<String, dynamic> json) =>
      ScanBarCodeDatum(
        id: json["id"] == null ? 0 : json["id"],
        productCode: json["product_code"] == null
            ? null.toString()
            : json["product_code"],
        proName: json["pro_name"] == null ? null.toString() : json["pro_name"],
        sku: json["sku"] == null ? null.toString() : json["sku"],
        itemUpc: json["item_upc"] == null ? null.toString() : json["item_upc"],
        item: json["item"] == null ? null.toString() : json["item"],
        // json["item"],
        unitCost:
            json["unit_cost"] == null ? null.toString() : json["unit_cost"],
        taxNumber:
            json["tax_number"] == null ? null.toString() : json["tax_number"],
        ebt: json["EBT"] == null ? 0 : json["EBT"],
        rebateGroup: json["rebate_group"] == null
            ? null.toString()
            : json["rebate_group"],
        //  json["rebate_group"],
        type: json["type"] == null ? null.toString() : json["type"],
        mixMatchGroup: json["mix_match_group"] == null
            ? null.toString()
            : json["mix_match_group"],
        inventoryGroup: json["inventory_group"] == null
            ? null.toString()
            : json["inventory_group"],
        cateId: json["cate_id"] == null ? 0 : json["cate_id"],
        cateName:
            json["cate_name"] == null ? null.toString() : json["cate_name"],
        price: json["price"] == null ? null.toString() : json["price"],
        cost: json["cost"] == null ? null.toString() : json["cost"],
        margin: json["margin"] == null ? null.toString() : json["margin"],
        onHandQty:
            json["on_hand_qty"] == null ? null.toString() : json["on_hand_qty"],
        qtyAvailable: json["qty_available"] == null
            ? null.toString()
            : json["qty_available"],
        packSize:
            json["pack_size"] == null ? null.toString() : json["pack_size"],
        packUpc: json["pack_upc"] == null ? null.toString() : json["pack_upc"],
        caseCost:
            json["case_cost"] == null ? null.toString() : json["case_cost"],
        vendorId: json["vendor_id"] == null ? 0 : json["vendor_id"],
        onSpecial: json["on_special"] == null ? 0 : json["on_special"],
        startDate:
            json["start_date"] == null ? null.toString() : json["start_date"],
        endDate: json["end_date"] == null ? null.toString() : json["end_date"],
        plu: json["plu"] == null ? null.toString() : json["plu"],
        //  json["plu"],
        packPrice:
            json["pack_price"] == null ? null.toString() : json["pack_price"],
        retailPrice: json["retail_price"] == null
            ? null.toString()
            : json["retail_price"],
        caseSize:
            json["case_size"] == null ? null.toString() : json["case_size"],
        specialPrice: json["special_price"] == null
            ? null.toString()
            : json["special_price"],
        loyaltyDescription: json["loyalty_description"] == null
            ? null.toString()
            : json["loyalty_description"],

        loyaltyPoint: json["loyalty_point"] == null
            ? null.toString()
            : json["loyalty_point"],
        weightItem: json["weight_item"] == null ? 0 : json["weight_item"],
        ebtEligible: json["ebt_eligible"] == null ? 0 : json["ebt_eligible"],
        wicEligible: json["wic_eligible"] == null ? 0 : json["wic_eligible"],
        activeItem: json["active_item"] == null ? 0 : json["active_item"],
        ingredient: json["ingredient"] == null ? 0 : json["ingredient"],
        showInMenu: json["show_in_menu"] == null ? 0 : json["show_in_menu"],
        showInKiosk: json["show_in_kiosk"] == null ? 0 : json["show_in_kiosk"],
        mustAskQty: json["must_ask_qty"] == null ? 0 : json["must_ask_qty"],
        inventory: json["inventory"] == null ? 0 : json["inventory"],
        kitchenPrinter:
            json["kitchen_printer"] == null ? 0 : json["kitchen_printer"],
        loyaltyAmount: json["loyalty_amount"] == null
            ? null.toString()
            : json["loyalty_amount"],
        sendToScale: json["send_to_scale"] == null ? 0 : json["send_to_scale"],
        unitId: json["unit_id"] == null ? 0 : json["unit_id"],
        subUnitIds: json["sub_unit_ids"] == null
            ? null.toString()
            : json["sub_unit_ids"],

        tax: json["tax"] == null ? null.toString() : json["tax"],
        taxAmount: json["tax_amount"],
        unitWeight:
            json["unit_weight"] == null ? null.toString() : json["unit_weight"],
        caseWeight:
            json["case_weight"] == null ? null.toString() : json["case_weight"],
        variationId: json["variation_id"] == null ? 0 : json["variation_id"],
        purchaseLineId:
            json["purchase_line_id"] == null ? 0 : json["purchase_line_id"],
        purchaseLineTaxId: json["purchase_line_tax_id"] == null
            ? null.toString()
            : json["purchase_line_tax_id"],
        stockOfProduct: json["enable_stock"] == null
            ? '0.0'
            : json["enable_stock"].toString(),
        subTotal: json["subTotal"] == null ? '0.0' : json["subTotal"].toString(),
        unitQty: json["unitQty"] == null ? '1.0' : json["unitQty"].toString(),
        mixmatchGroupIdApply : json["mixmatchGroupIdApply"] == null ?  []: json["mixmatchGroupIdApply"],
        mixMatchGroupApplied: json["mixMatchGroupApplied"] == null ? false : json["mixMatchGroupApplied"],
        subtotalAfterDiscount: json["subtotalAfterDiscount"] == null ? 0.0 : json["subtotalAfterDiscount"],
        discount: json["discount"] == null ? 0 : json["discount"],
        cartTax: json["cartTax"] == null ? 0.0 : json["cartTax"],
        ebtCart: json["ebtCart"] == null ? 0.0 : json["ebtCart"],
        cartLoyaltyPoints: json["cartLoyaltyPoints"] == null ? 0 : json["cartLoyaltyPoints"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null.toString() : id,
        "product_code": productCode == null ? null.toString() : productCode,
        "pro_name": proName == null ? null.toString() : proName,
        "sku": sku == null ? null.toString() : sku,
        "item_upc": itemUpc,
        "item": item,
        "unit_cost": unitCost == null ? null.toString() : unitCost,
        "tax_number": taxNumber == null ? null.toString() : taxNumber,
        "EBT": ebt == null ? null.toString() : ebt,
        "rebate_group": rebateGroup,
        "type": type == null ? null.toString() : type,
        "mix_match_group": mixMatchGroup,
        "inventory_group": inventoryGroup,
        "cate_id": cateId == null ? null.toString() : cateId,
        "cate_name": cateName == null ? null.toString() : cateName,
        "price": price == null ? null.toString() : price,
        "cost": cost == null ? null.toString() : cost,
        "margin": margin == null ? null.toString() : margin,
        "on_hand_qty": onHandQty == null ? null.toString() : onHandQty,
        "qty_available": qtyAvailable == null ? null.toString() : qtyAvailable,
        "pack_size": packSize,
        "pack_upc": packUpc,
        "case_cost": caseCost == null ? null.toString() : caseCost,
        "vendor_id": vendorId,
        "on_special": onSpecial == null ? null.toString() : onSpecial,
        "start_date": startDate,
        "end_date": endDate,
        "plu": plu,
        "pack_price": packPrice == null ? null.toString() : packPrice,
        "retail_price": retailPrice == null ? null.toString() : retailPrice,
        "case_size": caseSize == null ? null.toString() : caseSize,
        "special_price": specialPrice == null ? null.toString() : specialPrice,
        "loyalty_description": loyaltyDescription,
        "loyalty_point": loyaltyPoint == null ? null.toString() : loyaltyPoint,
        "weight_item": weightItem == null ? null.toString() : weightItem,
        "ebt_eligible": ebtEligible == null ? null.toString() : ebtEligible,
        "wic_eligible": wicEligible == null ? null.toString() : wicEligible,
        "active_item": activeItem == null ? null.toString() : activeItem,
        "ingredient": ingredient == null ? null.toString() : ingredient,
        "show_in_menu": showInMenu == null ? null.toString() : showInMenu,
        "show_in_kiosk": showInKiosk == null ? null.toString() : showInKiosk,
        "must_ask_qty": mustAskQty == null ? null.toString() : mustAskQty,
        "inventory": inventory == null ? null.toString() : inventory,
        "kitchen_printer":
            kitchenPrinter == null ? null.toString() : kitchenPrinter,
        "loyalty_amount":
            loyaltyAmount == null ? null.toString() : loyaltyAmount,
        "send_to_scale": sendToScale == null ? null.toString() : sendToScale,
        "unit_id": unitId == null ? null.toString() : unitId,
        "sub_unit_ids": subUnitIds,
        "tax": tax == null ? null.toString() : tax,
        "tax_amount": taxAmount,
        "unit_weight": unitWeight == null ? null.toString() : unitWeight,
        "case_weight": caseWeight == null ? null.toString() : caseWeight,
        "variation_id": variationId == null ? null.toString() : variationId,
        "purchase_line_id":
            purchaseLineId == null ? null.toString() : purchaseLineId,
        "purchase_line_tax_id": purchaseLineTaxId,
      };
}
