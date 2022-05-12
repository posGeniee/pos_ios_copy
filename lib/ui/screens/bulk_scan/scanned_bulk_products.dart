import 'dart:convert';

import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/bulk_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/bulk_scan_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/scalling.dart';
import 'package:dummy_app/ui/screens/bulk_scan/purchase/create_purchase.dart';
import 'package:edge_alerts/edge_alerts.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/network/pos_provider.dart';

class ScannedBulkProducts extends StatefulWidget {
  static const routeName = '/ScannedBulkProducts';

  const ScannedBulkProducts({
    Key? key,
  }) : super(key: key);

  @override
  _ScannedBulkProductsState createState() => _ScannedBulkProductsState();
}

class _ScannedBulkProductsState extends State<ScannedBulkProducts> {
  final ScrollController _listScrollPage = ScrollController();
  List<PurchaseBulkScanDatum>? items = [];

  bool loading = false, allLoaded = false;
  int pageNo = 1;
  var scannedCodeList = {};
  List list = [];
  int _index = 0;
  double extCost = 0.0;
  double orderUnit = 1.0;

  getApiData() {
    final data = Provider.of<BulkScanProvider>(context, listen: false)
        .bulkscanDataPurchaseGetter;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    var newData = data.asMap();

    for (var i in newData.entries.toList()) {
      list.add({'name[$i]': i.value.toString().trim()});

      list.forEach((customer) =>
          scannedCodeList['name[${i.key}]'] = customer['name[$i]']);
    }
    scannedCodeList.addEntries([
      MapEntry("location_id", locationId.toString()),
      const MapEntry("type", "multi-barcode"),
    ]);
    print("This is the scanned List ${scannedCodeList.cast<String, String>()}");
  }

  mockFetch() async {
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    if (allLoaded) {
      return;
    }
    if (!mounted) return;
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration.zero);
    print('This is the all products List page Number $pageNo');
    final responseString = await BulkScanApiCall().getAllProductData(
      locationId.toString(),
      token,
      pageNo,
      scannedCodeList.cast<String, String>(),
    );
    print("This is the Response ------------------ $responseString");

    List<PurchaseBulkScanDatum> newList = [];
    newList = purchaseBulkScanFromMap(responseString).message!.data!;

    //HardCoded Unit = 1.0;

    if (newList.isNotEmpty) {
      if (!mounted) return;
      setState(() {
        pageNo++;
      });
      for (var item in newList) {
        items!.add(item);

        //Munually hardCoded Intialize..
        //Formula (caseSize * orderUnit)

        // Total Item = allproductCaseCost.

      }
      Provider.of<BulkScanProvider>(context, listen: false)
          .purchaseBulkScanSetter(items);
    }

    if (!mounted) return;
    setState(() {
      loading = false;
      allLoaded = newList.isEmpty;
    });
  }

  @override
  void initState() {
    getApiData();
    mockFetch();
    _listScrollPage.addListener(() {
      if (_listScrollPage.offset <= _listScrollPage.position.minScrollExtent &&
          !_listScrollPage.position.outOfRange) {}
      if (_listScrollPage.position.pixels >=
              _listScrollPage.position.maxScrollExtent &&
          !loading) {
        print("this is the New Data Call----");
        mockFetch();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _listScrollPage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          'Scanned Items Details',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final locationId =
                  Provider.of<AuthRequest>(context, listen: false)
                      .locationFromApiGetter
                      .id;
              final token = Provider.of<AuthRequest>(context, listen: false)
                  .signiModelGetter
                  .data!
                  .bearer;
              showLoading();
              final purchases =
                  Provider.of<BulkScanProvider>(context, listen: false)
                      .purchasesGetter;
              await Future.delayed(
                const Duration(seconds: 1),
              );
              await BulkScanApiCall()
                  .takeOrderPurchase(locationId.toString(), token, purchases);
              dismissLoading();
              edgeAlert(context,
                  backgroundColor: Colors.green,
                  title: 'Purchases Added Successfully');
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: LayoutBuilder(builder: (context, constraits) {
        final totalCases = Provider.of<BulkScanProvider>(
          context,
        ).totalCasesGetter;
        final totalUnits = Provider.of<BulkScanProvider>(
          context,
        ).totalUnitsGetter;
        final totalItems = Provider.of<BulkScanProvider>(
          context,
        ).totalItemsGetter;
        final itemAmount = Provider.of<BulkScanProvider>(
          context,
        ).totalAmountGetter;
        final returnAmount = Provider.of<BulkScanProvider>(
          context,
        ).returnAmountGetter;
        final netTotalAmount = Provider.of<BulkScanProvider>(
          context,
        ).netTotalAmountGetter;
        if (items!.isNotEmpty) {
          final listofData = Provider.of<BulkScanProvider>(context)
              .purchaseBulkScanGetter
              .message!
              .data;
          return Stack(
            children: [
              SizedBox(
                height: 120,
                child: PageView(
                  controller: PageController(viewportFraction: 0.8),
                  onPageChanged: (int index) => setState(() => _index = index),
                  children: [
                    Transform.scale(
                      scale: 0 == _index ? 0.9 : 0.8,
                      alignment: Alignment.centerLeft,
                      child: AppCardWidget(
                        itemValue: totalCases.toStringAsFixed(2),
                        itemName: 'TOTAL CASES',
                      ),
                    ),
                    Transform.scale(
                      scale: 1 == _index ? 0.9 : 0.8,
                      alignment: Alignment.centerLeft,
                      child: AppCardWidget(
                        itemValue: totalUnits.toStringAsFixed(2),
                        itemName: 'TOTAL UNITS',
                      ),
                    ),
                    Transform.scale(
                      scale: 2 == _index ? 0.9 : 0.8,
                      alignment: Alignment.centerLeft,
                      child: AppCardWidget(
                        itemValue: totalItems.toStringAsFixed(2),
                        itemName: 'TOTAL ITEMS',
                      ),
                    ),
                    Transform.scale(
                      scale: 3 == _index ? 0.9 : 0.8,
                      alignment: Alignment.centerLeft,
                      child: AppCardWidget(
                        itemValue: itemAmount.toStringAsFixed(2),
                        itemName: 'ITEM AMOUNT',
                      ),
                    ),
                    Transform.scale(
                      scale: 4 == _index ? 0.9 : 0.8,
                      alignment: Alignment.centerLeft,
                      child: AppCardWidget(
                        itemValue: returnAmount.toStringAsFixed(2),
                        itemName: 'RETURN AMOUNT',
                      ),
                    ),
                    Transform.scale(
                      scale: 5 == _index ? 0.9 : 0.8,
                      alignment: Alignment.centerLeft,
                      child: AppCardWidget(
                        itemValue: netTotalAmount.toStringAsFixed(2),
                        itemName: 'NET TOTAL AMOUNT',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: ListView.separated(
                  controller: _listScrollPage,
                  itemBuilder: (context, index) {
                    if (index < listofData!.length) {
                      return ListTile(
                        isThreeLine: true,
                        leading: CircleAvatar(
                          child: Text('$index'),
                        ),
                        onTap: () async {
                          await Navigator.of(context).pushNamed(
                              CreatePurchaseEditProduct.routeName,
                              arguments: listofData[index]);

                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                                const SnackBar(content: Text('Updated -- ')));
                        },
                        title: Text(listofData[index].proName),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listofData[index].productCode),
                            Text('Dept : ${listofData[index].cateName}'),
                          ],
                        ),
                        trailing: Column(
                          children: [
                            Text((extCost / orderUnit).toString()),
                            Text(
                                '${double.parse(listofData[index].onHandQty).toStringAsFixed(2)} OnHand'),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: constraits.maxWidth,
                        height: 50,
                        child: const Center(
                          child: Text("Nothing more to Load "),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1,
                    );
                  },
                  itemCount: listofData!.length + (allLoaded ? 1 : 0),
                ),
              ),
              if (loading) ...[
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: 80,
                    width: constraits.maxWidth,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ],
          );
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      }),
    );
  }
}

class AppCardWidget extends StatelessWidget {
  final String itemName;
  String itemValue;

  AppCardWidget({
    Key? key,
    required this.itemName,
    required this.itemValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var posProvider = Provider.of<PosSectionProvider>(context);
    init(context);
    return Card(
      // color: buttonColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              buttonColor,
              Colors.lightBlue,
              buttonColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        billItems('Ebt'),
                        billItems(''),
                        billItems(''),
                        billItems(''),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        billItems(posProvider.totalEbtGetter.toStringAsFixed(2)),
                        billItems(''),
                        billItems(''),
                        billItems(''),
                      ],
                    ),
                  ],
                ),
              ),
              const VerticalDivider(color: Colors.white, thickness: 0.5),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        billItems(itemName),
                        billItems('Tax'),
                        billItems('Discount'),
                        billItems('TOTAL'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        billItems(itemValue),
                        billItems(posProvider.totalTaxGetter.toStringAsFixed(2)),
                        billItems(posProvider.totalDiscountGetter.toString()),
                        billItems(posProvider.totalGetter.toStringAsFixed(2)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row billItems(String nameValue) {
    return Row(
                children: [
                  Text(
                    nameValue,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
  }
}

final pageViewdata = [];
