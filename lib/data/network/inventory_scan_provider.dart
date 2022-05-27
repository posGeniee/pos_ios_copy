import 'package:dummy_app/data/models/item%20search%20model/scan_bar_code.dart';
import 'package:dummy_app/data/models/item%20search%20model/search_products_with_plu_group&mixMatchModel.dart';
import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';
import 'package:dummy_app/ui/screens/bulk_scan/purchase/create_purchase.dart';
// import 'package:catcher/catcher.dart';
import 'package:edge_alerts/edge_alerts.dart';

import 'package:flutter/material.dart';

import 'dart:convert';

import '../../main.dart';

class InventoryScanProvider with ChangeNotifier {
  List<ScanBarCodeDatum> _inventoryScannedItems = [];
  List<DatumSearchProductsWithPluGroupMixMatch> _inventoryscanData = [];
  List<InventoryScanSendData>? _apiSendData = [];
  final PurchaseBulkScan _invenotoryScanResult = PurchaseBulkScan(
    code: 200,
    message: PurchaseBulkScanMessage(
        currentPage: 0,
        data: [],
        firstPageUrl: "0",
        from: 0,
        lastPage: 0,
        lastPageUrl: "0",
        links: [],
        nextPageUrl: "0",
        path: "0",
        perPage: 0,
        prevPageUrl: "0",
        to: 0,
        total: 0),
  );
  PurchaseBulkScan get purchaseBulkScanGetter {
    return _invenotoryScanResult;
  }

  List<InventoryScanSendData>? get inventoryBulkScanGetter {
    return _apiSendData;
  }

  inventoryBulkScanSetter(
    List<PurchaseBulkScanDatum>? listTemp,
  ) {
    _invenotoryScanResult.code = 200;
    _invenotoryScanResult.message!.data = listTemp;
    // print(
    //     'This is the Cost ${_invenotoryScanResult.message!.data![1].unitCost}');
    notifyListeners();
    for (var item in listTemp!) {
      _apiSendData!.add(
        InventoryScanSendData(
            productId: item.id.toString(),
            variationId: item.variationId.toString(),
            enableStock: item.stockOfProduct,
            quantity: item.extCost,
            unitPrice: item.unitCost,
            price: (double.parse(item.unitCost) * double.parse(item.extCost))
                .toStringAsFixed(2)),
      );
    }
  }

  inventoryDataEdit(PurchaseBulkScanDatum bulkScanDatum) {
    _invenotoryScanResult.message!.data!.where((element) {
      if (element.id == bulkScanDatum.id) {
        element.extCost = bulkScanDatum.extCost;
        element.unitCost = bulkScanDatum.unitCost;
        notifyListeners();
      }
      return false;
    });
    for (var item
        in _invenotoryScanResult.message!.data as List<PurchaseBulkScanDatum>) {
      _apiSendData = [];
      _apiSendData!.add(
        InventoryScanSendData(
            productId: item.id.toString(),
            variationId: item.variationId.toString(),
            enableStock: item.stockOfProduct,
            quantity: item.extCost,
            unitPrice: item.unitCost,
            price: (double.parse(item.unitCost) * double.parse(item.extCost))
                .toStringAsFixed(2)),
      );
    }
  }

  List<DatumSearchProductsWithPluGroupMixMatch> get inventoryscanDataGetter {
    return _inventoryscanData;
  }

  List<ScanBarCodeDatum> get inventoryscanDataListGetter {
    return _inventoryScannedItems;
  }

  addInventoryScanData(ScanBarCodeDatum codeDatum) {
    List<ScanBarCodeDatum> newList = [];
    if (_inventoryScannedItems.isEmpty) {
      print('This is the Running -- ');
      _inventoryScannedItems.add(codeDatum);
      notifyListeners();
    } else {
      for (var e in _inventoryScannedItems) {
        if (e.id == codeDatum.id) {
          edgeAlert(
            navKey.currentState!.context,
            title: 'Provided product will not be added due to Duplication',
            backgroundColor: Colors.red,
          );
        } else {
          newList.add(codeDatum);
        }
      }
      if (newList.isNotEmpty) {
        _inventoryScannedItems.addAll(newList);
        notifyListeners();
      }
    }
  }

  removeInventoryScanData(ScanBarCodeDatum codeDatum) {
    _inventoryScannedItems.removeWhere((element) => element.id == codeDatum.id);
    notifyListeners();
  }

  emptyInventoryScanData() {
    _inventoryScannedItems = [];
    notifyListeners();
  }

  addInventoryScan(DatumSearchProductsWithPluGroupMixMatch scanData) {
    final data = _inventoryscanData
        .where((element) => element.id == scanData.id)
        .toList();
    print("This is the Data 12345 $data");
    if (data.isNotEmpty) {
      edgeAlert(
        navKey.currentContext,
        backgroundColor: Colors.red,
        title: 'Item Added Previously',
      );
    } else {
      _inventoryscanData.add(scanData);
      edgeAlert(navKey.currentContext,
          backgroundColor: Colors.green, title: 'Invenory Scan Item Added');
      notifyListeners();
    }
  }
}

// To parse this JSON data, do
//
//     final inventoryScanSendData = inventoryScanSendDataFromMap(jsonString);

List<InventoryScanSendData> inventoryScanSendDataFromMap(String str) =>
    List<InventoryScanSendData>.from(
        json.decode(str).map((x) => InventoryScanSendData.fromMap(x)));

String inventoryScanSendDataToMap(List<InventoryScanSendData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class InventoryScanSendData {
  InventoryScanSendData({
    required this.productId,
    required this.variationId,
    required this.enableStock,
    required this.quantity,
    required this.unitPrice,
    required this.price,
  });

  String productId;
  String variationId;
  String enableStock;
  String quantity;
  String unitPrice;
  String price;

  factory InventoryScanSendData.fromMap(Map<String, dynamic> json) =>
      InventoryScanSendData(
        productId: json["product_id"] == null ? null : json["product_id"],
        variationId: json["variation_id"] == null ? null : json["variation_id"],
        enableStock: json["enable_stock"] == null ? null : json["enable_stock"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        unitPrice: json["unit_price"] == null ? null : json["unit_price"],
        price: json["price"] == null ? null : json["price"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId == null ? null : productId,
        "variation_id": variationId == null ? null : variationId,
        "enable_stock": enableStock == null ? null : enableStock,
        "quantity": quantity == null ? null : quantity,
        "unit_price": unitPrice == null ? null : unitPrice,
        "price": price == null ? null : price,
      };
}
