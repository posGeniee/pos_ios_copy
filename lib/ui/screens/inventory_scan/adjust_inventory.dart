import 'package:dummy_app/data/models/Inventory_scan/list_of_inventory_model.dart';
import 'package:dummy_app/data/models/item%20search%20model/scan_bar_code.dart';
import 'package:dummy_app/data/models/item%20search%20model/search_products_with_plu_group&mixMatchModel.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/inventory_scan_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/item_search_api_function.dart';
import 'package:dummy_app/ui/screens/inventory_scan/scanned_Inventory.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AdjustInventory extends StatefulWidget {
  static const routeName = '/AdjustInventory';
  const AdjustInventory({Key? key}) : super(key: key);

  @override
  _AdjustInventoryState createState() => _AdjustInventoryState();
}

class _AdjustInventoryState extends State<AdjustInventory> {
  final price = TextEditingController();
  final barCodeId = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _showLoading() async {
    SmartDialog.showLoading(
      backDismiss: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as DatumInventoryListModel;
    final listofScannedData =
        Provider.of<InventoryScanProvider>(context).inventoryscanDataGetter;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Adjust Inventory",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'To scan using Camera. Continuously Scan Items and Press cancel on the camera to Stop. *Click Update button on screen or on (Top Right Corner).',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: buttonColor,
                      fontSize: 18,
                    ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () async {
                  await [
                    Permission.camera,
                  ].request();
                  final requestAccessCamera = await Permission.camera.isGranted;
                  if (requestAccessCamera) {
                    // Navigator.of(context)
                    //     .pushNamed(ScanInventoryList.routeName);
                  }
                },
                icon: const Icon(
                  CupertinoIcons.camera,
                  color: buttonColor,
                ),
                label: Text(
                  'Scan BarCodes (Continuous):',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: barCodeId,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  // readOnly: readOnly,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter BarCode Id';
                    }

                    return null;
                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'Please enter BarCode Id',
                    labelText: 'Search by BarCode Id',
                  ),

                  onFieldSubmitted: (value) async {
                    if (_formKey.currentState!.validate() == true) {
                      _showLoading();
                      final token =
                          Provider.of<AuthRequest>(context, listen: false)
                              .signiModelGetter
                              .data!
                              .bearer;
                      final data = await ItemSearchApiFuncion()
                          .searchFromBarCode(barCodeId.text, token);
                      final response = scanBarCodeFromMap(data);
                      print(
                          "This is the Check Regarding Data ${response.message!.data}");
                      if (response.message!.data!.isEmpty) {
                        SmartDialog.dismiss();
                        edgeAlert(
                          context,
                          title: 'BarCode is not in the database',
                          backgroundColor: Colors.red,
                        );
                        if (!mounted) return;
                        setState(() {
                          barCodeId.clear();
                        });
                      } else {
                        final newData = response.message!.data![0];
                        Provider.of<InventoryScanProvider>(context,
                                listen: false)
                            .addInventoryScan(
                          DatumSearchProductsWithPluGroupMixMatch(
                            packPrice: newData.packPrice,
                            cateId: newData.cateId,
                            cost: newData.cost,
                            cateName: newData.cateName,
                            ebt: newData.ebt,
                            image: "newData.image",
                            id: newData.id,
                            margin: newData.margin,
                            onHandQty: newData.onHandQty,
                            packSize: newData.packSize,
                            packUpc: newData.packUpc,
                            price: newData.price,
                            proName: newData.proName,
                            productCode: newData.productCode,
                            sku: newData.sku,
                            taxNumber: newData.taxNumber,
                            vendorId: newData.vendorId,
                          ),
                        );
                        if (!mounted) return;
                        setState(() {
                          barCodeId.clear();
                        });

                        SmartDialog.dismiss();
                      }
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Scanned BarCode : ${listofScannedData.isNotEmpty ? listofScannedData.length : '0'}",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: buttonColor),
              ),
              if (listofScannedData.isNotEmpty)
                ...listofScannedData.map(
                  (e) => Card(
                    margin: EdgeInsets.only(top: 5),
                    child: Center(
                      child: ListTile(
                        title: Text(
                          e.proName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 60,
                                  child: TextFormField(
                                    readOnly: true,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter current password';
                                      }

                                      return null;
                                    },

                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: e.cateName,
                                      labelText: "Dpt.",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 60,
                                  child: TextFormField(
                                    controller: price,
                                    readOnly: false,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter current password';
                                      }

                                      return null;
                                    },

                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: double.parse(e.onHandQty)
                                          .toStringAsFixed(2),
                                      labelText: "Qty",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 400,
                  //   child: ListView.separated(
                  //       itemBuilder: (context, index) {
                  //         return ListTile(
                  //           onTap: () {
                  //             // Navigator.of(context).pushNamed(
                  //             //   AdjustInventory.routeName,
                  //             //   arguments: listofScannedData.data![index],
                  //             // );
                  //           },
                  //           isThreeLine: true,
                  //           leading: CircleAvatar(
                  //             child: Text('$index'),
                  //           ),
                  //           title: Text("listofScannedData[index].proName"),
                  //           subtitle: Text("listofScannedData[index].cateName"),
                  //           trailing: Row(
                  //             children: [
                  //               Text("listofScannedData[index].onHandQty"),
                  //               IconButton(
                  //                 onPressed: () {},
                  //                 icon: Icon(CupertinoIcons.forward),
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       },
                  //       separatorBuilder: (context, index) {
                  //         return const Divider();
                  //       },
                  //       itemCount: 1),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
