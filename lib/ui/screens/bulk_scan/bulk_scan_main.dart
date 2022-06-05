import 'package:dummy_app/data/models/item%20search%20model/vendor_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/bulk_provider.dart';
import 'package:dummy_app/data/network/business_provider.dart';
import 'package:dummy_app/data/network/item_search_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/bulk_scan_api_function.dart';
import 'package:dummy_app/ui/screens/bulk_scan/bulk_scannner.dart';
import 'package:dummy_app/ui/screens/bulk_scan/scanned_bulk_products.dart';
import 'package:dummy_app/ui/screens/bulk_scan/widgets/edit_bank_widget.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/widgets/vendor_edit.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class BulkScanMian extends StatefulWidget {
  static const routeName = '/BulkScanMian';
  const BulkScanMian({Key? key}) : super(key: key);

  @override
  State<BulkScanMian> createState() => _BulkScanMianState();
}

class _BulkScanMianState extends State<BulkScanMian> {
  @override
  void initState() {
    // Provider.of<ItemSearchProvider>(context, listen: false)
    //     .changeselectedVendor(
    //   DatumVendor(
    //     supplier: 'null',
    //     id: 0,
    //   ),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listofScannedData =
        Provider.of<BulkScanProvider>(context).bulkscanDataPurchaseGetter;
    final suppelier =
        Provider.of<ItemSearchProvider>(context).vendorSelectedGetter.supplier;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Bulk Scan ",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (listofScannedData.isEmpty || suppelier.contains('null')) {
                edgeAlert(
                  context,
                  title: 'Provide Scan Item or Vendor',
                  backgroundColor: Colors.red,
                );
              } else {
                Navigator.of(context).pushNamed(ScannedBulkProducts.routeName);
              }
            },
            icon: Icon(
              CupertinoIcons.arrow_right_circle,
              color: listofScannedData.isEmpty ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(18),
                child: VendorEditTextFormField(),
              ),
              const Padding(
                padding: EdgeInsets.all(18),
                child: BankEditTextFormField(),
              ),
              Text(
                'To scan using Camera. Continuously Scan Items and Press cancel on the camera to Stop. *Click arrow button on screen or on (Top Right Corner).',
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
                    Navigator.of(context).pushNamed(ScanBulkScanList.routeName);
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
                          e,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              Provider.of<BulkScanProvider>(context,
                                      listen: false)
                                  .removeBulkScanItemPurchase(e);
                            },
                            icon: const Icon(CupertinoIcons.minus_circle)),
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
