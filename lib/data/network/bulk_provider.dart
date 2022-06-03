import 'dart:convert';

import 'package:dummy_app/data/models/purchase_scan/bank_list_model.dart';
import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';
import 'package:dummy_app/ui/screens/bulk_scan/purchase/create_purchase.dart';
import 'package:dummy_app/ui/screens/overview/overview_main.dart';
import 'package:catcher/catcher.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';

class BulkScanProvider with ChangeNotifier {
  final List<String> _bulkscanDataPurchase = [
    // '0978',
    // '9864',
    // '093',
    // '827',
  ];
  // final List<String> _bulkscanDataPurchase = ['0978', '9864'];
  final List<String> _bulkscanDataReturn = ['0978'];
  List<OrderPageScan>? apiSendData = [];
  BankListModelMessage _bankListModelMessage =
      BankListModelMessage(bankName: 'null', id: 0);
  final PurchaseBulkScan _bulkScanData = PurchaseBulkScan(
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
// TotalCase = allOrderCaseSum
  double _totalCases = 0;
// Total Units = allUnitSum
  double _totalUnits = 0;
  // Total Item = allproductCaseCost.
  double _totalItems = 0;
// ITEM AMOUNT = extCostSumPurchase +  extCostSumReturn
  double _totalItemAmount = 0;
// RETURN AMOUNT = extCostSumReturn
  double _returnAmount = 0;
  // NET TOTAL AMOUNT = ITEM AMOUNT - RETURN AMOUNT;
  double _netTotalAmount = 0;
  double get totalCasesGetter {
    return _totalCases;
  }

  PurchaseBulkScan get purchaseBulkScanGetter {
    return _bulkScanData;
  }

  BankListModelMessage get bankListModelMessageGetter {
    return _bankListModelMessage;
  }

  bankListModelMessageSetter(BankListModelMessage tempbankListModelMessage) {
    _bankListModelMessage = tempbankListModelMessage;
    notifyListeners();
  }

  String get purchasesGetter {
    return json.encode(List<dynamic>.from(apiSendData!.map((x) => x.toMap())));
  }

  purchaseBulkScanSetter(
    List<PurchaseBulkScanDatum>? listTemp,
  ) {
    _bulkScanData.code = 200;
    _bulkScanData.message!.data = listTemp;

    //temp total Cases

    //Total Units
    notifyListeners();
    totalCalculationsForList(listTemp);
    for (var item in listTemp!) {
      apiSendData!.add(
        OrderPageScan(
          plu: item.sku,
          description: item.proName.toString(),
          item: item.itemId,
          packageUpc: item.packageUPC,
          department: item.departmentId,
          taxNumber: item.taxNumber.toString(),
          ebt: item.ebt.toString(),
          wic: item.wicEligible,
          qtyOnHand: item.onHandQty.toString(),
          caseSize: item.caseSize.toString(),
          orderUnit: item.orderUnit,
          productId: item.id.toString(),
          variationId: item.variationId.toString(),
          quantity: "36.00",
          productUnitId: item.unitId,
          subUnitId: item.subunitId,
          orderCase: item.packSize.toString(),
          productItemStatus: "0",
          productItemType: "purchase",
          extCost: item.unitCost,
          caseCost: item.caseCost,
          caseRetail: item.caseRetial,
          caseMargin: item.caseMargin,
          unitCost: item.unitCost,
          purchasePrice: item.unitCost,
          ppWithoutDiscount: item.unitCost,
          discountPercent: "0.00",
          newRetail: item.newRetailPrice,
          currentRetail: item.newRetailPrice,
          purchaseLineTaxId: item.purchaseLineId.toString(),
          itemTax: "0.00",
          purchasePriceIncTax: "41.67",
          profitPercent: item.profitMargin,
          defaultSellPrice: "0.0",
        ),
      );
    }
  }

  totalCalculationsForList(List<PurchaseBulkScanDatum>? listTemp) {
    listTemp = _bulkScanData.message!.data;

    double tempTotalCase = 0.0;

    double tempTotalUnits = 0.0;
    double tempTotalItems = 0.0;
    double tempTotalAmount = 0.0;
    //Hard Coded
    double tempOrderCase = 1.0;
    //Have to do
    double returnAmount = 0.0;
    double temporderUnit = 1.0;
    for (var item in listTemp!) {
      tempTotalCase = (double.parse(item.caseSize) == 0)
          ? double.parse("1.0") + tempTotalCase
          : double.parse(item.caseSize) + tempTotalCase;
      _totalCases = tempTotalCase;
      tempTotalUnits = ((double.parse(item.caseSize) == 0)
              ? double.parse("1.0") * temporderUnit
              : double.parse(item.caseSize) * temporderUnit) +
          tempTotalUnits;
      _totalUnits = tempTotalUnits;
      // Total Item = allproductCaseCost.
      tempTotalItems = double.parse(item.caseCost) + tempTotalItems;
      _totalItems = tempTotalItems;
      // orderCase * caseCost
      tempTotalAmount =
          (double.parse(item.caseCost) * tempOrderCase) + tempTotalAmount;
      _totalItemAmount = tempTotalAmount;
      //TODO:// Functionality Pending
      returnAmount = returnAmount;
      _netTotalAmount = tempTotalAmount - returnAmount;
      notifyListeners();
    }
  }

  totalCalculationForItem(PurchaseBulkScanDatum bulkScanDatumTemp) {
    _bulkScanData.message!.data!.where((element) {
      if (element.id == bulkScanDatumTemp.id) {
        element = bulkScanDatumTemp;
        notifyListeners();
      }
      return element.id == bulkScanDatumTemp.id;
    }).toList();
    totalCalculationsForList(_bulkScanData.message!.data!);
  }

  totalCasesSetter(double total) {
    _totalCases = total;
    notifyListeners();
  }

  double get totalUnitsGetter {
    return _totalUnits;
  }

  totalUnitsSetter(double total) {
    _totalUnits = total;
    notifyListeners();
  }

  double get totalItemsGetter {
    return _totalItems;
  }

  totalItemsSetter(double total) {
    _totalItems = total;
    notifyListeners();
  }

  double get totalAmountGetter {
    return _totalItemAmount;
  }

  totalAmountSetter(double total) {
    _totalItemAmount = total;
    notifyListeners();
  }

  double get returnAmountGetter {
    return _returnAmount;
  }

  returnAmountSetter(double total) {
    _returnAmount = total;
    notifyListeners();
  }

  double get netTotalAmountGetter {
    return _netTotalAmount;
  }

  netTotalAmountSetter(double total) {
    _netTotalAmount = total;
    notifyListeners();
  }

  List<String> get bulkscanDataPurchaseGetter {
    return _bulkscanDataPurchase;
  }

  List<String> get bulkscanDataReturnGetter {
    return _bulkscanDataReturn;
  }

  addBulkScanItemPurchase(String scanData) {
    final data =
        _bulkscanDataPurchase.where((element) => element == scanData).toList();

    if (data.isNotEmpty) {
      edgeAlert(
        Catcher.navigatorKey!.currentContext,
        backgroundColor: Colors.red,
        title: 'Item Added Previously',
      );
    } else {
      _bulkscanDataPurchase.add(scanData);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          backgroundColor: Colors.green, title: 'Invenory Scan Item Added');
      notifyListeners();
    }
  }

  removeBulkScanItemPurchase(String scanData) {
    final data =
        _bulkscanDataPurchase.where((element) => element == scanData).toList();
    print("This is the Data 12345 $data");
    if (data.isNotEmpty) {
      edgeAlert(
        Catcher.navigatorKey!.currentContext,
        backgroundColor: Colors.red,
        title: 'BarCode Item ($scanData) Remove Sucessfully',
      );
      _bulkscanDataPurchase.remove(scanData);
      notifyListeners();
    } else {
      // _bulkscanData.add(scanData);
      // edgeAlert(Catcher.navigatorKey!.currentContext,
      //     backgroundColor: Colors.green, title: 'Invenory Scan Item Added');
      notifyListeners();
    }
  }

  addBulkScanItemReturn(String scanData) {
    final data =
        _bulkscanDataPurchase.where((element) => element == scanData).toList();

    if (data.isNotEmpty) {
      edgeAlert(
        Catcher.navigatorKey!.currentContext,
        backgroundColor: Colors.red,
        title: 'Item Added Previously',
      );
    } else {
      _bulkscanDataPurchase.add(scanData);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          backgroundColor: Colors.green, title: 'Invenory Scan Item Added');
      notifyListeners();
    }
  }
}
