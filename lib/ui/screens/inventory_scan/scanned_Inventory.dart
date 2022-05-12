import 'dart:convert';

import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/bulk_provider.dart';
import 'package:dummy_app/data/network/inventory_scan_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/bulk_scan_api_function.dart';
import 'package:dummy_app/helpers/helper%20function%20api/inventory_scan_api__function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/bulk_scan/purchase/create_purchase.dart';
import 'package:dummy_app/ui/screens/inventory_scan/invetory_item_detail.dart';
import 'package:edge_alerts/edge_alerts.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ScannedInventoryProducts extends StatefulWidget {
  static const routeName = '/ScannedInventoryProducts';
  const ScannedInventoryProducts({
    Key? key,
  }) : super(key: key);

  @override
  _ScannedInventoryProductsState createState() =>
      _ScannedInventoryProductsState();
}

class _ScannedInventoryProductsState extends State<ScannedInventoryProducts> {
  final ScrollController _listScrollPage = ScrollController();
  List<PurchaseBulkScanDatum>? items = [];
  final _formKey = GlobalKey<FormState>();
  bool loading = false, allLoaded = false;
  int pageNo = 1;
  var scannedCodeList = {};
  List list = [];
  int _index = 0;
  double extCost = 0.0;
  double orderUnit = 1.0;
  final refName = TextEditingController();
  final totalAmountRecovered = TextEditingController();
  final reason = TextEditingController();

  String adjustmentType = 'Normal';

  getApiData() {
    final data = Provider.of<InventoryScanProvider>(context, listen: false)
        .inventoryscanDataListGetter;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    var newData = data.asMap();

    for (var i in newData.entries.toList()) {
      list.add({'name[$i]': i.value.sku.toString().trim()});

      list.forEach((customer) =>
          scannedCodeList['name[${i.key}]'] = customer['name[$i]']);
    }
    scannedCodeList.addEntries([
      MapEntry("location_id", locationId.toString()),
      const MapEntry("type", "multi-barcode"),
    ]);
    print("This the request Passing ${scannedCodeList}");
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
    if (!mounted) return; setState(() {
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
      if (!mounted) return; setState(() {
        pageNo++;
      });
      for (var item in newList) {
        items!.add(item);
      }
      Provider.of<InventoryScanProvider>(context, listen: false)
          .inventoryBulkScanSetter(items);
    }

    if (!mounted) return; setState(() {
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
              if (_formKey.currentState!.validate()) {
                showLoading();
                final listForApi =
                    Provider.of<InventoryScanProvider>(context, listen: false)
                        .inventoryBulkScanGetter;
                final locationId =
                    Provider.of<AuthRequest>(context, listen: false)
                        .locationFromApiGetter
                        .id;
                final token = Provider.of<AuthRequest>(context, listen: false)
                    .signiModelGetter
                    .data!
                    .bearer;
                final refNoText = refName.text;
                final transactionDate =
                    '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
                final adjustMentData = adjustmentType.toLowerCase();
                double total = 0;
                final listofData =
                    Provider.of<InventoryScanProvider>(context, listen: false)
                        .purchaseBulkScanGetter;
                listofData.message!.data!.map((e) {
                  total = (double.parse(e.extCost) * double.parse(e.unitCost)) +
                      total;
                  return null;
                }).toList();
                final totalAmountRecoveredData = totalAmountRecovered.text;
                final resonData = reason.text;

                final String data = inventoryScanSendDataToMap(listForApi!);
                await IventoryScanApiCall().updateStock(
                    locationId.toString(),
                    token,
                    refNoText,
                    transactionDate,
                    adjustMentData,
                    total.toString(),
                    data,
                    totalAmountRecoveredData,
                    resonData);
                dismissLoading();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.send),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (context, constraits) {
        if (items!.isNotEmpty) {
          final listofData = Provider.of<InventoryScanProvider>(context)
              .purchaseBulkScanGetter;
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      newAppField(refName, 'Ref No', TextInputType.name, [],
                          TextInputAction.next,
                          readOnly: false),
                      newAppField(
                          totalAmountRecovered,
                          'Total Amount Recovered',
                          TextInputType.number,
                          [FilteringTextInputFormatter.digitsOnly],
                          TextInputAction.next,
                          readOnly: false),
                      newAppField(reason, 'Reason', TextInputType.name, [],
                          TextInputAction.next,
                          readOnly: false),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextButton.icon(
                          onPressed: () async {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30)),
                              ),
                              builder: (BuildContext _) {
                                return Wrap(
                                  children: [
                                    ListTile(
                                      leading: Text(
                                        '0',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(color: Colors.white),
                                      ),
                                      title: Text(
                                        'Normal',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      onTap: () {
                                        if (!mounted) return; setState(() {
                                          adjustmentType = 'Normal';
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      trailing: (adjustmentType == "Normal")
                                          ? const Icon(
                                              CupertinoIcons
                                                  .check_mark_circled_solid,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              CupertinoIcons.checkmark,
                                              color: Colors.white,
                                            ),
                                    ),
                                    ListTile(
                                      leading: Text(
                                        '0',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(color: Colors.white),
                                      ),
                                      title: Text(
                                        'Abnormal',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      trailing: (adjustmentType == "Abnormal")
                                          ? const Icon(
                                              CupertinoIcons
                                                  .check_mark_circled_solid,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              CupertinoIcons.checkmark,
                                              color: Colors.white,
                                            ),
                                      onTap: () {
                                        if (!mounted) return; setState(() {
                                          adjustmentType = 'Abnormal';
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                  alignment: WrapAlignment.center,
                                );
                              },
                              isScrollControlled: true,
                            );
                          },
                          icon: const Icon(
                            CupertinoIcons.ellipsis_circle_fill,
                            color: Colors.green,
                            size: 18,
                          ),
                          label: Text(
                            'Adjustment Type',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                            controller: _listScrollPage,
                            itemBuilder: (context, index) {
                              if (index < listofData.message!.data!.length) {
                                return ListTile(
                                  isThreeLine: true,
                                  onTap: () async {
                                    Navigator.of(context).pushNamed(
                                      InventoryItemDetail.routeName,
                                      arguments:
                                          listofData.message!.data![index],
                                    );
                                  },
                                  title: RichText(
                                    text: TextSpan(
                                      text: '',
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Name : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: listofData
                                              .message!.data![index].proName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        )
                                      ],
                                    ),
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: '',
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Qty : ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: listofData.message!
                                                  .data![index].extCost,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            )
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: '',
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Price : ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: listofData.message!
                                                  .data![index].unitCost,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: const Text(''),
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
                              return const Divider(
                                height: 1,
                              );
                            },
                            itemCount: listofData.message!.data!.length +
                                (allLoaded ? 1 : 0)),
                      ),
                    ],
                  ),
                ),
              ),
              if (loading) ...[
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: 80,
                    width: constraits.maxWidth,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ],
          );
        } else {
          return Container(
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      }),
    );
  }
}

class AppCardWidget extends StatelessWidget {
  final String itemName;
  final String itemValue;
  const AppCardWidget({
    Key? key,
    required this.itemValue,
    required this.itemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: buttonColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            itemName,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            itemValue,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

final pageViewdata = [];
