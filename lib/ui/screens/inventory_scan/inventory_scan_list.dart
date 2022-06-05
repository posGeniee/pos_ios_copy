import 'package:dummy_app/data/models/item%20search%20model/scan_bar_code.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/inventory_scan_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/item_search_api_function.dart';
import 'package:dummy_app/ui/screens/inventory_scan/scanned_Inventory.dart';

import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class InventoryScanList extends StatefulWidget {
  static const routeName = '/InventoryScanList';
  const InventoryScanList({Key? key}) : super(key: key);

  @override
  State<InventoryScanList> createState() => _InventoryScanListState();
}

class _InventoryScanListState extends State<InventoryScanList> {
  final barCodeId = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final barCodeName = TextEditingController();
  void _showLoading() async {
    SmartDialog.showLoading(
      backDismiss: false,
    );
  }

  initializeData() async {
    await Future.delayed(Duration.zero);
    Provider.of<InventoryScanProvider>(context, listen: false)
        .emptyInventoryScanData();
  }

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryScannedItems =
        Provider.of<InventoryScanProvider>(context).inventoryscanDataListGetter;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Inventory Item Search',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton.icon(
              onPressed: () async {
                if (inventoryScannedItems.isEmpty) {
                  edgeAlert(
                    context,
                    backgroundColor: Colors.red,
                    title: 'Inventory Items are Empty',
                  );
                } else {
                  Navigator.of(context)
                      .pushNamed(ScannedInventoryProducts.routeName);
                }

                // showModalBottomSheet(
                //   context: context,
                //   shape: const RoundedRectangleBorder(
                //     borderRadius:
                //         BorderRadius.vertical(top: Radius.circular(30)),
                //   ),
                //   builder: (BuildContext _) {
                //     return Wrap(
                //       children: [
                //         ListTile(
                //           leading: Text(
                //             '0',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .subtitle1!
                //                 .copyWith(color: Colors.white),
                //           ),
                //           title: Text(
                //             'Add Plu Group',
                //             style: Theme.of(context).textTheme.subtitle1,
                //           ),
                //           onTap: () {
                //             Navigator.of(context)
                //                 .pushNamed(AddPluGroup.routeName);
                //           },
                //         ),
                //         ListTile(
                //           leading: Text(
                //             '0',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .subtitle1!
                //                 .copyWith(color: Colors.white),
                //           ),
                //           title: Text(
                //             'Add Mix Match Group',
                //             style: Theme.of(context).textTheme.subtitle1,
                //           ),
                //           onTap: () {
                //             Navigator.of(context)
                //                 .pushNamed(AddMixMatchGroup.routeName);
                //           },
                //         ),
                //       ],
                //       alignment: WrapAlignment.center,
                //     );
                //   },
                //   isScrollControlled: true,
                // );
              },
              icon: Icon(
                CupertinoIcons.arrow_right_circle,
                color:
                    inventoryScannedItems.isEmpty ? Colors.grey : Colors.green,
                size: 18,
              ),
              label: Text(
                'Proceed',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Type, Scan or Click the Camera Icon to scan from camera. Click Go button on mobile keyboard to proceed',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: buttonColor,
                    fontSize: 18,
                  ),
              textAlign: TextAlign.justify,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () async {
                  await [
                    Permission.camera,
                  ].request();
                  final requestAccessCamera = await Permission.camera.isGranted;
                  if (requestAccessCamera) {}
                },
                icon: const Icon(
                  CupertinoIcons.camera,
                  color: buttonColor,
                ),
                label: Text(
                  'Scan by Bar Code Image',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 30,
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
                    final token =
                        Provider.of<AuthRequest>(context, listen: false)
                            .signiModelGetter
                            .data!
                            .bearer;
                    // _showLoading();
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
                    } else {
                      final newData = response.message!.data![0];
                      if (double.parse(newData.stockOfProduct) > 0) {
                        print(
                            'InventoryScan item will be added ${newData.stockOfProduct}');
                        Provider.of<InventoryScanProvider>(context,
                                listen: false)
                            .addInventoryScanData(newData);
                      } else {
                        edgeAlert(
                          context,
                          title:
                              'Product is available but Stock is not Available',
                          backgroundColor: Colors.red,
                        );
                      }

                      // Navigator.of(context).pushNamed(
                      //   EditProduct.routeName,
                      //   arguments: newData,
                      // );
                      // SmartDialog.dismiss();
                    }
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Scanned Inventory Item : ${inventoryScannedItems.length}',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      isThreeLine: true,
                      onTap: () async {},
                      title: RichText(
                        text: TextSpan(
                          text: '',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'BarCode : ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: inventoryScannedItems[index].sku,
                              style: Theme.of(context).textTheme.headline6,
                            )
                          ],
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Unit cost : ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: double.parse(
                                          inventoryScannedItems[index].unitCost)
                                      .toStringAsFixed(2),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Stock : ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: inventoryScannedItems[index]
                                      .stockOfProduct,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            Provider.of<InventoryScanProvider>(context,
                                    listen: false)
                                .removeInventoryScanData(
                                    inventoryScannedItems[index]);
                            edgeAlert(
                              context,
                              title: 'Product removed Successfully',
                              backgroundColor: Colors.red,
                            );
                          },
                          icon: Icon(
                            CupertinoIcons.minus_circle,
                            color: Colors.red,
                          )),
                    ),
                  );
                },
                itemCount: inventoryScannedItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
