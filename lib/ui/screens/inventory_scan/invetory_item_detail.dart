
import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';
import 'package:dummy_app/data/network/inventory_scan_provider.dart';
import 'package:dummy_app/helpers/widget.dart';

import 'package:dummy_app/ui/screens/item_search/plu_group_prod_graph.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_summary.dart';
import 'package:edge_alerts/edge_alerts.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class InventoryItemDetail extends StatefulWidget {
  static const routeName = '/InventoryItemDetail';
  const InventoryItemDetail({Key? key}) : super(key: key);

  @override
  _InventoryItemDetailState createState() => _InventoryItemDetailState();
}

class _InventoryItemDetailState extends State<InventoryItemDetail> {
  // void _showLoading() async {
  //   SmartDialog.showLoading(
  //     backDismiss: false,
  //   );
  // }

  final lookUpUpc = TextEditingController(text: 'superadmin');
  final itemName = TextEditingController(text: 'superadmin');
  final itemQty = TextEditingController(text: 'superadmin');
  final itemUnitPrice = TextEditingController(text: 'superadmin');
  final itemSubTotal = TextEditingController(text: 'superadmin');

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      final args =
          ModalRoute.of(context)!.settings.arguments as PurchaseBulkScanDatum;
      double subTotalManipulation =
          (double.parse(args.extCost) * double.parse(args.unitCost));

      lookUpUpc.text = args.sku.toString();
      itemName.text = args.proName;
      itemQty.text = args.extCost;
      itemUnitPrice.text = args.unitCost;
      itemSubTotal.text = subTotalManipulation.isNaN
          ? "0.0"
          : subTotalManipulation.toStringAsFixed(2);
    });

    super.initState();
  }

  @override
  void dispose() {
    lookUpUpc.dispose();
    itemName.dispose();
    itemQty.dispose();
    itemUnitPrice.dispose();
    itemSubTotal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PurchaseBulkScanDatum;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Item Entry',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                PluGroupProdGraph.routeName,
                arguments: ScreenArguments('${args.id}'),
              );
            },
            icon: const Icon(Icons.auto_graph_outlined),
          ),
          IconButton(
            onPressed: () async {
              Provider.of<InventoryScanProvider>(context, listen: false)
                  .inventoryDataEdit(args);
              edgeAlert(
                context,
                backgroundColor: Colors.green,
                title: 'Inventory Saved Successfully',
              );
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            appField(lookUpUpc, 'Lookup UPC (Read Only)',
                TextInputType.emailAddress, TextInputAction.next,
                fieldsubmited: () async {}, readOnly: true),
            appField(itemName, 'Item Name', TextInputType.emailAddress,
                TextInputAction.next,
                fieldsubmited: () async {}, readOnly: true),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: itemQty,
                readOnly: false,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter current password';
                  }

                  return null;
                },

                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (double.parse(args.stockOfProduct) <
                        double.parse(value)) {
                      edgeAlert(
                        context,
                        title: 'Enter Qty is Greater then Stock',
                        backgroundColor: Colors.red,
                      );
                      if (!mounted) return; setState(() {
                        itemQty.text = args.extCost;
                      });
                    } else {
                      if (!mounted) return; setState(() {
                        itemSubTotal.text = (double.parse(itemQty.text) *
                                double.parse(itemUnitPrice.text))
                            .toStringAsFixed(2);
                        args.extCost = itemQty.text;
                      });
                    }
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Quantity',
                  labelText: 'Quantity',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: itemUnitPrice,
                readOnly: false,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter current password';
                  }

                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (!mounted) return; setState(() {
                      itemSubTotal.text = (double.parse(itemQty.text) *
                              double.parse(itemUnitPrice.text))
                          .toStringAsFixed(2);
                      args.unitCost = itemUnitPrice.text;
                    });
                  }
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Unit Price',
                  labelText: 'Unit Price',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: itemSubTotal,
                readOnly: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter current password';
                  }

                  return null;
                },

                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Sub Total',
                  labelText: 'Sub Total',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
