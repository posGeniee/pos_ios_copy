import 'dart:convert';

import 'package:dummy_app/data/models/item%20search%20model/scan_bar_code.dart';
import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';
import 'package:dummy_app/data/network/bulk_provider.dart';
import 'package:dummy_app/data/network/item_search_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:flutter/cupertino.dart';

//
import 'package:dummy_app/data/models/item%20search%20model/search_products_with_plu_group&mixMatchModel.dart';
import 'package:dummy_app/helpers/helper%20function%20api/item_search_api_function.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/widgets/department_edit.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/widgets/tags_edit.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/widgets/vendor_edit.dart';
import 'package:dummy_app/ui/screens/item_search/plu_group_prod_graph.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class CreatePurchaseEditProduct extends StatefulWidget {
  static const routeName = '/CreatePurchaseEditProduct';
  const CreatePurchaseEditProduct({Key? key}) : super(key: key);

  @override
  _CreatePurchaseEditProductState createState() =>
      _CreatePurchaseEditProductState();
}

class _CreatePurchaseEditProductState extends State<CreatePurchaseEditProduct> {
  void _showLoading() async {
    SmartDialog.showLoading(
      backDismiss: false,
    );
  }

  final lookUpUpc = TextEditingController(text: 'superadmin');
  final itemskuId = TextEditingController(text: 'superadmin');
  final itemName = TextEditingController(text: 'superadmin');
  final itemNo = TextEditingController(text: 'superadmin');
  final pkgUPC = TextEditingController(text: 'superadmin');

  final wic = TextEditingController(text: 'superadmin');

  final onHandQty = TextEditingController(text: 'superadmin');
  final caseSize = TextEditingController(text: 'superadmin');
  final margin = TextEditingController(text: 'superadmin');

  final packSize = TextEditingController(text: 'superadmin');
  final packUpc = TextEditingController(text: 'superadmin');
  final packPrice = TextEditingController(text: 'superadmin');
  final orderUnit = TextEditingController(text: 'superadmin');
  final orderCase = TextEditingController(text: 'superadmin');
  //
  final extraCost = TextEditingController(text: 'superadmin');
  final caseCost = TextEditingController(text: 'superadmin');
  final unitCost = TextEditingController(text: 'superadmin');
  final newRetailCost = TextEditingController(text: 'superadmin');
  final currentretail = TextEditingController(text: 'superadmin');
  final profitMargin = TextEditingController(text: 'superadmin');
  final caseRetail = TextEditingController(text: 'superadmin');
  final caseMargin = TextEditingController(text: 'superadmin');

  final taxSize = TextEditingController(text: 'superadmin');
  final ebT = TextEditingController(text: 'superadmin');
  //Vendor  Name Missing
  final vendorName = TextEditingController(text: 'superadmin');
  final active = TextEditingController(text: 'superadmin');

  valueChangedTextField() {
    //ON Hand Qty is not Changed
//Case Size will be Changed Manually
//Order Unit Change
    if (caseSize.text.isNotEmpty) {
      orderUnit.text = '1.0';
      if (!mounted) return; setState(() {
        var data = double.parse(orderCase.text) * double.parse(caseSize.text);
        orderUnit.text = data.toString();
      });
    }
    //Ext Cost Formula
    if (orderCase.text.isNotEmpty) {
      orderUnit.text = '1.0';
      if (!mounted) return; setState(() {
        var data = double.parse(orderCase.text) * double.parse(caseCost.text);
        extraCost.text = data.toString();
      });
    }
    //Case Cost Formula
    if (extraCost.text.isNotEmpty &&
        orderUnit.text.isNotEmpty &&
        orderCase.text.isNotEmpty) {
      unitCost.text = '1.0';
      caseCost.text = '1.0';
      if (!mounted) return; setState(() {
        var data = double.parse(extraCost.text) / double.parse(orderUnit.text);
        unitCost.text = data.toString();
        var data2 = double.parse(extraCost.text) / double.parse(orderCase.text);
        caseCost.text = data2.toString();
      });
    }
    //Case Cost Calculated
    //Case Retail Manually Data Change
    if (caseMargin.text.isNotEmpty && caseCost.text.isNotEmpty) {
      if (!mounted) return; setState(() {
        var data = (double.parse(caseRetail.text) -
                double.parse(caseCost.text) -
                double.parse(caseCost.text)) /
            100;
        caseMargin.text = data.toString();
      });
    }
    if (newRetailCost.text.isNotEmpty && unitCost.text.isNotEmpty) {
      if (!mounted) return; setState(() {
        var data =
            ((double.parse(newRetailCost.text) - double.parse(unitCost.text)) /
                    double.parse(unitCost.text)) *
                100;
        // var data2 =
        //     ((double.parse(newRetailCost.text) - double.parse(unitCost.text)) /
        //             double.parse(unitCost.text)) *
        //         100;
        profitMargin.text = data.toString();
      });
    }

    // Order Case will be Changed Manually.
    //new Retail Formula
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final args =
          ModalRoute.of(context)!.settings.arguments as PurchaseBulkScanDatum;
      lookUpUpc.text = (args.plu.contains('null')) ? ' ' : args.plu.toString();
      itemskuId.text = args.sku;
      pkgUPC.text = args.packageUPC;

      itemName.text = args.proName;
      itemNo.text =
          (args.itemId.contains('null')) ? ' ' : args.itemId.toString();
      double caseSizeManipulation = (double.parse(args.caseSize) == 0)
          ? double.parse("1.0")
          : double.parse(args.caseSize);

      double extCostManipulation =
          double.parse(args.orderCase) * double.parse(args.caseCost);
      double caseMarginManipulation = ((double.parse(args.caseMargin) -
              double.parse(args.caseCost) / double.parse(args.caseCost)) *
          100);
      double caseRetailManipulation = ((double.parse(args.caseMargin) -
              double.parse(args.caseCost) / double.parse(args.caseCost)) *
          100);
      var profitMarginManipulation =
          ((double.parse(args.newRetailPrice) - double.parse(args.unitCost)) /
                  double.parse(args.unitCost)) *
              100;

      onHandQty.text = double.parse(args.onHandQty).toStringAsFixed(2);
      caseSize.text = caseSizeManipulation.toString();

      double.parse("1.0").toStringAsFixed(2);
      args.unitCost =
          (double.parse(args.orderCase) * caseSizeManipulation).toString();
      orderUnit.text = args.unitCost;

      //Order Unit
      args.orderCase = double.parse(args.orderCase).toStringAsFixed(2);
      orderCase.text = args.orderCase;
      //extra Cost
      args.extCost = extCostManipulation.toString();
      extraCost.text = args.extCost;
      // Case Cost
      caseCost.text = double.parse(args.caseCost).toStringAsFixed(2);
      // Unit Cost
      unitCost.text = double.parse(args.unitCost).toStringAsFixed(2);
      // New Retail Cost
      newRetailCost.text = double.parse(args.newRetailPrice).toStringAsFixed(2);
      // New Current Cost
      currentretail.text = double.parse(args.newRetailPrice).toStringAsFixed(2);

      args.profitMargin = profitMarginManipulation.isNaN
          ? 0.0.toString()
          : profitMarginManipulation.toStringAsFixed(2);
      profitMargin.text = args.profitMargin;

      // packSize.text = args.packSize.toString();
      // packUpc.text = args.packUpc.toString();
      // packPrice.text = args.packPrice;
      taxSize.text = args.taxNumber;

      caseRetail.text = args.caseRetial;
      args.caseMargin = caseMarginManipulation.isNaN
          ? 0.0.toString()
          : caseMarginManipulation.toStringAsFixed(2);
      caseMargin.text = args.caseMargin;

      // onHand.text = double.parse(args.onHandQty).toStringAsFixed(2);
      if (double.parse(args.wicEligible) == 1) {
        wic.text = 'Yes';
      } else {
        wic.text = 'No';
      }
      if (args.ebt == 1) {
        ebT.text = 'Yes';
      } else {
        ebT.text = 'No';
      }
    });

    super.initState();
  }

  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PurchaseBulkScanDatum;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
            );
            final department =
                Provider.of<ItemSearchProvider>(context, listen: false)
                    .departmentSelectedGetter;
            if (args.cateName != department.name) {
              if (!mounted) return; setState(() {
                args.departmentId = department.name;
                args.cateName = department.name;
              });
            }
            Provider.of<BulkScanProvider>(context, listen: false)
                .totalCalculationForItem(args);
          },
        ),
        title: Text(
          'Item Purchase Entry',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
                final department =
                    Provider.of<ItemSearchProvider>(context, listen: false)
                        .departmentSelectedGetter;
                if (args.cateName != department.name) {
                  if (!mounted) return; setState(() {
                    args.departmentId = department.name;
                    args.cateName = department.name;
                  });
                }

                Provider.of<BulkScanProvider>(context, listen: false)
                    .totalCalculationForItem(args);
              },
              icon: const Icon(CupertinoIcons.arrow_up_circle)),
        ],
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pushNamed(PluGroupProdGraph.routeName);
        //     },
        //     icon: Icon(Icons.auto_graph_outlined),
        //   ),
        //   // IconButton(
        //   //   onPressed: () async {
        //   //     print("The Save is Runing ---------------");
        //   //     _showLoading();

        //   //     await ItemSearchApiFuncion().saveProduct(
        //   //       catId: args.cateId.toString(),
        //   //       caseSize: caseSize.text,
        //   //       eBT: (ebT.text == "Yes") ? 1.toString() : 0.toString(),
        //   //       name: itemName.text,
        //   //       netMargin: margin.text,
        //   //       onHandQty: onHand.text,
        //   //       packPrice: packPrice.text,
        //   //       packSize: packPrice.text,
        //   //       packUpc: packUpc.text,
        //   //       onHandQty: onHandQty.text,
        //   //       productId: args.id.toString(),
        //   //       productcode: args.productCode,
        //   //       sku: args.sku,
        //   //       taxNumber:
        //   //           (taxSize.text == "TAX") ? 1.toString() : 0.toString(),
        //   //       vendorId: args.vendorId,
        //   //     );
        //   //     SmartDialog.dismiss();
        //   //     edgeAlert(
        //   //       context,
        //   //       backgroundColor: Colors.green,
        //   //       title: 'Product Saved Successfully',
        //   //     );
        //   //     print("The Save is Runned ---------------");
        //   //     // Navigator.of(context).pushNamed(PluGroupProdGraph.routeName);
        //   //   },
        //   //   icon: const Icon(Icons.save),
        //   // ),

        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Show Details : ',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 26),
                ),
                CupertinoSwitch(
                  value: _switchValue,
                  activeColor: buttonColor,
                  onChanged: (value) {
                    if (!mounted) return; setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ],
            ),
            appField(itemskuId, 'Lookup UPC (Read Only)',
                TextInputType.emailAddress, TextInputAction.next,
                fieldsubmited: () async {}, readOnly: true),
            appField(lookUpUpc, 'PLU (Read Only)', TextInputType.emailAddress,
                TextInputAction.next,
                fieldsubmited: () async {}, readOnly: true),
            // appField(itemName, 'Item Name', TextInputType.emailAddress,
            //     TextInputAction.next,
            //     fieldsubmited: () async {}, readOnly: true),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: itemName,
                readOnly: false,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Item Name';
                  }
                  // if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //             .hasMatch(value) ==
                  //         false &&
                  //     labelText.contains("Email")) {
                  //   return 'Please enter valid email';
                  // }

                  return null;
                },

                decoration: InputDecoration(
                  hintText: 'Please enter Item Name',
                  labelText: 'Item Name',
                ),
                onChanged: (value) {
                  if (!mounted) return; setState(() {
                    args.proName = value;
                  });
                },
                onFieldSubmitted: (value) {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: itemNo,
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
                      if (!mounted) return; setState(() {
                        args.itemId = value;
                      });
                    },

                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Item #',
                      labelText: 'Item #',
                    ),
                  ),
                ),
                if (_switchValue)
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: TextFormField(
                      controller: pkgUPC,
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
                          orderUnit.text = '1.0';
                          if (!mounted) return; setState(() {
                            args.packageUPC = pkgUPC.text;
                          });
                        }
                      },

                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Pkg UPC',
                        labelText: 'Pkg UPC',
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: onHandQty,
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
                    onChanged: (value) {},

                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'On Hand',
                      labelText: 'On Hand',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: caseSize,
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
                        final totalUnits = Provider.of<BulkScanProvider>(
                                context,
                                listen: false)
                            .totalUnitsGetter;
                        var data = totalUnits - 1;
                        orderUnit.text = '1.0';

                        if (!mounted) return; setState(() {
                          var data = double.parse(orderCase.text) *
                              double.parse(caseSize.text);
                          orderUnit.text = data.toString();

                          args.orderUnit = orderUnit.text;
                          args.caseSize = caseSize.text;
                        });
                        data = data + double.parse(orderUnit.text);
                      }
                    },

                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Case Size',
                      labelText: 'Case Size',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: orderUnit,
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
                      hintText: 'Order Unit',
                      labelText: 'Order Unit',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: orderCase,
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
                        orderUnit.text = '1.0';
                        if (!mounted) return; setState(() {
                          var data = double.parse(orderCase.text) *
                              double.parse(caseSize.text);
                          orderUnit.text = data.toString();

                          args.orderUnit = data.toString();
                        });
                      }
                    },

                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Order Case',
                      labelText: 'Order Case',
                    ),
                  ),
                ),
              ],
            ),
            if (_switchValue)
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: DepartmentEditTextForField(),
              ),
            if (_switchValue == false)
              const SizedBox(
                height: 18,
              ),
            if (_switchValue)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: TextFormField(
                      controller: taxSize,
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(30)),
                          ),
                          builder: (BuildContext _) {
                            return Container(
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: Text(
                                      1.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: Colors.white),
                                    ),
                                    title: Text(
                                      "TAX",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    trailing: (taxSize.text == "TAX")
                                        ? Icon(
                                            CupertinoIcons
                                                .check_mark_circled_solid,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            CupertinoIcons.checkmark,
                                            color: Colors.white,
                                          ),
                                    onTap: () {
                                      if (!mounted) return; setState(() {
                                        taxSize.text = "TAX";
                                        args.taxNumber = taxSize.text;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: Text(
                                      0.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: Colors.white),
                                    ),
                                    title: Text(
                                      "NON TAX",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    trailing: (taxSize.text == "NON TAX")
                                        ? Icon(
                                            CupertinoIcons
                                                .check_mark_circled_solid,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            CupertinoIcons.checkmark,
                                            color: Colors.white,
                                          ),
                                    onTap: () {
                                      if (!mounted) return; setState(() {
                                        taxSize.text = "NON TAX";
                                        args.taxNumber = taxSize.text;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                                alignment: WrapAlignment.center,
                              ),
                            );
                          },
                          isScrollControlled: true,
                        );
                      },
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
                        hintText: 'Tax Number',
                        labelText: 'Tax Number',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: TextFormField(
                      controller: ebT,
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter current password';
                        }

                        return null;
                      },
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(30)),
                          ),
                          builder: (BuildContext _) {
                            return Container(
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: Text(
                                      1.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: Colors.white),
                                    ),
                                    title: Text(
                                      "Yes",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    trailing: (ebT.text == "Yes")
                                        ? Icon(
                                            CupertinoIcons
                                                .check_mark_circled_solid,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            CupertinoIcons.checkmark,
                                            color: Colors.white,
                                          ),
                                    onTap: () {
                                      if (!mounted) return; setState(() {
                                        ebT.text = "Yes";
                                        args.ebt = 1;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: Text(
                                      0.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: Colors.white),
                                    ),
                                    title: Text(
                                      "No",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    trailing: (ebT.text == "No")
                                        ? Icon(
                                            CupertinoIcons
                                                .check_mark_circled_solid,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            CupertinoIcons.checkmark,
                                            color: Colors.white,
                                          ),
                                    onTap: () {
                                      if (!mounted) return; setState(() {
                                        ebT.text = "No";
                                        args.ebt = 0;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                                alignment: WrapAlignment.center,
                              ),
                            );
                          },
                          isScrollControlled: true,
                        );
                      },
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'EBT',
                        labelText: 'EBT',
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 18,
            ),
            if (_switchValue)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width / 2.5,
                  //   child: TextFormField(
                  //     controller: taxSize,
                  //     readOnly: true,
                  //     keyboardType: TextInputType.number,
                  //     onTap: () {
                  //       showModalBottomSheet(
                  //         context: context,
                  //         shape: const RoundedRectangleBorder(
                  //           borderRadius:
                  //               BorderRadius.vertical(top: Radius.circular(30)),
                  //         ),
                  //         builder: (BuildContext _) {
                  //           return Container(
                  //             child: Wrap(
                  //               children: [
                  //                 ListTile(
                  //                   leading: Text(
                  //                     1.toString(),
                  //                     style: Theme.of(context)
                  //                         .textTheme
                  //                         .subtitle1!
                  //                         .copyWith(color: Colors.white),
                  //                   ),
                  //                   title: Text(
                  //                     "TAX",
                  //                     style:
                  //                         Theme.of(context).textTheme.subtitle1,
                  //                   ),
                  //                   trailing: (taxSize.text == "TAX")
                  //                       ? Icon(
                  //                           CupertinoIcons
                  //                               .check_mark_circled_solid,
                  //                           color: Colors.green,
                  //                         )
                  //                       : Icon(
                  //                           CupertinoIcons.checkmark,
                  //                           color: Colors.white,
                  //                         ),
                  //                   onTap: () {
                  //                     if (!mounted) return; setState(() {
                  //                       taxSize.text = "TAX";
                  //                     });
                  //                     Navigator.of(context).pop();
                  //                   },
                  //                 ),
                  //                 ListTile(
                  //                   leading: Text(
                  //                     0.toString(),
                  //                     style: Theme.of(context)
                  //                         .textTheme
                  //                         .subtitle1!
                  //                         .copyWith(color: Colors.white),
                  //                   ),
                  //                   title: Text(
                  //                     "NON TAX",
                  //                     style:
                  //                         Theme.of(context).textTheme.subtitle1,
                  //                   ),
                  //                   trailing: (taxSize.text == "NON TAX")
                  //                       ? Icon(
                  //                           CupertinoIcons
                  //                               .check_mark_circled_solid,
                  //                           color: Colors.green,
                  //                         )
                  //                       : Icon(
                  //                           CupertinoIcons.checkmark,
                  //                           color: Colors.white,
                  //                         ),
                  //                   onTap: () {
                  //                     if (!mounted) return; setState(() {
                  //                       taxSize.text = "NON TAX";
                  //                     });
                  //                     Navigator.of(context).pop();
                  //                   },
                  //                 ),
                  //               ],
                  //               alignment: WrapAlignment.center,
                  //             ),
                  //           );
                  //         },
                  //         isScrollControlled: true,
                  //       );
                  //     },
                  //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  //     // The validator receives the text that the user has entered.
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Please enter current password';
                  //       }

                  //       return null;
                  //     },

                  //     textInputAction: TextInputAction.next,
                  //     decoration: const InputDecoration(
                  //       hintText: 'Tax Number',
                  //       labelText: 'Tax Number',
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: TextFormField(
                      controller: wic,
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter current password';
                        }

                        return null;
                      },
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(30)),
                          ),
                          builder: (BuildContext _) {
                            return Container(
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: Text(
                                      1.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: Colors.white),
                                    ),
                                    title: Text(
                                      "Yes",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    trailing: (wic.text == "Yes")
                                        ? Icon(
                                            CupertinoIcons
                                                .check_mark_circled_solid,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            CupertinoIcons.checkmark,
                                            color: Colors.white,
                                          ),
                                    onTap: () {
                                      if (!mounted) return; setState(() {
                                        wic.text = "Yes";
                                        args.wicEligible = "1";
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: Text(
                                      0.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: Colors.white),
                                    ),
                                    title: Text(
                                      "No",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    trailing: (wic.text == "No")
                                        ? Icon(
                                            CupertinoIcons
                                                .check_mark_circled_solid,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            CupertinoIcons.checkmark,
                                            color: Colors.white,
                                          ),
                                    onTap: () {
                                      if (!mounted) return; setState(() {
                                        wic.text = "No";
                                        args.wicEligible = "0";
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                                alignment: WrapAlignment.center,
                              ),
                            );
                          },
                          isScrollControlled: true,
                        );
                      },
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'wic',
                        labelText: 'wic',
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 18,
            ),
            if (_switchValue)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: TextFormField(
                      controller: caseRetail,
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
                        if (caseMargin.text.isNotEmpty &&
                            caseCost.text.isNotEmpty) {
                          if (!mounted) return; setState(() {
                            var data = (double.parse(caseRetail.text) -
                                    double.parse(caseCost.text) -
                                    double.parse(caseCost.text)) /
                                100;
                            caseMargin.text = data.toString();
                            args.caseMargin = caseMargin.text;
                            args.caseRetial = caseRetail.text;
                          });
                        }
                        // if (value.isNotEmpty) {
                        //   unitCost.text = '1.0';
                        //   caseCost.text = '1.0';
                        //   if (!mounted) return; setState(() {
                        //     var data = double.parse(value) /
                        //         double.parse(orderUnit.text);
                        //     unitCost.text = data.toString();
                        //     var data2 = double.parse(value) /
                        //         double.parse(orderCase.text);
                        //     caseCost.text = data2.toString();
                        //   });
                        // }
                      },

                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Case Retail',
                        labelText: 'Case Retail',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: TextFormField(
                      controller: caseMargin,
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
                        hintText: 'Case Margin',
                        labelText: 'Case Margin',
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: extraCost,
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
                        unitCost.text = '1.0';
                        caseCost.text = '1.0';
                        if (!mounted) return; setState(() {
                          var data = double.parse(value) /
                              double.parse(orderUnit.text);
                          unitCost.text = data.toString();
                          unitCost.text = args.unitCost;
                          var data2 = double.parse(value) /
                              double.parse(orderCase.text);
                          caseCost.text = data2.toString();
                          args.caseCost = caseCost.text;
                          args.extCost = extraCost.text;
                        });
                      }
                    },

                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Ext Cost',
                      labelText: 'Ext Cost',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: caseCost,
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
                      hintText: 'Case Cost',
                      labelText: 'Case Cost',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: unitCost,
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
                      hintText: 'Unit Cost',
                      labelText: 'Unit Cost',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: newRetailCost,
                    readOnly: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter current password';
                      }

                      return null;
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        profitMargin.text = '1.0';
                        if (!mounted) return; setState(() {
                          var data = ((double.parse(value) -
                                      double.parse(unitCost.text)) /
                                  double.parse(unitCost.text)) *
                              100;
                          profitMargin.text = data.toStringAsFixed(2);
                          args.profitMargin = profitMargin.text;
                          args.newRetailPrice = newRetailCost.text;
                        });
                      }
                    },

                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Retail(N)',
                      labelText: 'Retail(N)',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: currentretail,
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
                      hintText: 'Retail(C)',
                      labelText: 'Retail(C)',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: profitMargin,
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
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        // orderUnit.text = '1.0';
                        // if (!mounted) return; setState(() {
                        //   var data = double.parse(orderCase.text) *
                        //       double.parse(caseSize.text);
                        //   orderUnit.text = data.toString();
                        // });
                      }
                    },

                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Profit (%)',
                      labelText: 'Profit (%)',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderPageScan {
  OrderPageScan({
    required this.plu,
    required this.description,
    required this.item,
    required this.packageUpc,
    required this.department,
    required this.taxNumber,
    required this.ebt,
    required this.wic,
    required this.qtyOnHand,
    required this.caseSize,
    required this.orderUnit,
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.productUnitId,
    required this.subUnitId,
    required this.orderCase,
    required this.productItemStatus,
    required this.productItemType,
    required this.extCost,
    required this.caseCost,
    required this.caseRetail,
    required this.caseMargin,
    required this.unitCost,
    required this.purchasePrice,
    required this.ppWithoutDiscount,
    required this.discountPercent,
    required this.newRetail,
    required this.currentRetail,
    required this.purchaseLineTaxId,
    required this.itemTax,
    required this.purchasePriceIncTax,
    required this.profitPercent,
    required this.defaultSellPrice,
  });

  String plu;
  String description;
  String item;
  String packageUpc;
  String department;
  String taxNumber;
  String ebt;
  String wic;
  String qtyOnHand;
  String caseSize;
  String orderUnit;
  String productId;
  String variationId;
  String quantity;
  String productUnitId;
  String subUnitId;
  String orderCase;
  String productItemStatus;
  String productItemType;
  String extCost;
  String caseCost;
  String caseRetail;
  String caseMargin;
  String unitCost;
  String purchasePrice;
  String ppWithoutDiscount;
  String discountPercent;
  String newRetail;
  String currentRetail;
  String purchaseLineTaxId;
  String itemTax;
  String purchasePriceIncTax;
  String profitPercent;
  String defaultSellPrice;

  factory OrderPageScan.fromMap(Map<String, dynamic> json) => OrderPageScan(
        plu: json["plu"] == null ? '' : json["plu"],
        description: json["description"] == null ? '' : json["description"],
        item: json["item"] == null ? '' : json["item"],
        packageUpc: json["package_upc"] == null ? '' : json["package_upc"],
        department: json["department"] == null ? '' : json["department"],
        taxNumber: json["tax_number"] == null ? '' : json["tax_number"],
        ebt: json["ebt"] == null ? '' : json["ebt"],
        wic: json["wic"] == null ? '' : json["wic"],
        qtyOnHand: json["qty_on_hand"] == null ? '' : json["qty_on_hand"],
        caseSize: json["case_size"] == null ? '' : json["case_size"],
        orderUnit: json["order_unit"] == null ? '' : json["order_unit"],
        productId: json["product_id"] == null ? '' : json["product_id"],
        variationId: json["variation_id"] == null ? '' : json["variation_id"],
        quantity: json["quantity"] == null ? '' : json["quantity"],
        productUnitId:
            json["product_unit_id"] == null ? '' : json["product_unit_id"],
        subUnitId: json["sub_unit_id"] == null ? '' : json["sub_unit_id"],
        orderCase: json["order_case"] == null ? '' : json["order_case"],
        productItemStatus: json["product_item_status"] == null
            ? ''
            : json["product_item_status"],
        productItemType:
            json["product_item_type"] == null ? '' : json["product_item_type"],
        extCost: json["ext_cost"] == null ? '' : json["ext_cost"],
        caseCost: json["case_cost"] == null ? '' : json["case_cost"],
        caseRetail: json["case_retail"] == null ? '' : json["case_retail"],
        caseMargin: json["case_margin"] == null ? '' : json["case_margin"],
        unitCost: json["unit_cost"] == null ? '' : json["unit_cost"],
        purchasePrice:
            json["purchase_price"] == null ? '' : json["purchase_price"],
        ppWithoutDiscount: json["pp_without_discount"] == null
            ? ''
            : json["pp_without_discount"],
        discountPercent:
            json["discount_percent"] == null ? '' : json["discount_percent"],
        newRetail: json["new_retail"] == null ? '' : json["new_retail"],
        currentRetail:
            json["current_retail"] == null ? '' : json["current_retail"],
        purchaseLineTaxId: json["purchase_line_tax_id"] == null
            ? ''
            : json["purchase_line_tax_id"],
        itemTax: json["item_tax"] == null ? '' : json["item_tax"],
        purchasePriceIncTax: json["purchase_price_inc_tax"] == null
            ? ''
            : json["purchase_price_inc_tax"],
        profitPercent:
            json["profit_percent"] == null ? '' : json["profit_percent"],
        defaultSellPrice: json["default_sell_price"] == null
            ? ''
            : json["default_sell_price"],
      );

  Map<String, dynamic> toMap() => {
        "plu": plu == null ? '' : plu,
        "description": description == null ? '' : description,
        "item": item == null ? '' : item,
        "package_upc": packageUpc == null ? '' : packageUpc,
        "department": department == null ? '' : department,
        "tax_number": taxNumber == null ? '' : taxNumber,
        "ebt": ebt == null ? '' : ebt,
        "wic": wic == null ? '' : wic,
        "qty_on_hand": qtyOnHand == null ? '' : qtyOnHand,
        "case_size": caseSize == null ? '' : caseSize,
        "order_unit": orderUnit == null ? '' : orderUnit,
        "product_id": productId == null ? '' : productId,
        "variation_id": variationId == null ? '' : variationId,
        "quantity": quantity == null ? '' : quantity,
        "product_unit_id": productUnitId == null ? '' : productUnitId,
        "sub_unit_id": subUnitId == null ? '' : subUnitId,
        "order_case": orderCase == null ? '' : orderCase,
        "product_item_status":
            productItemStatus == null ? '' : productItemStatus,
        "product_item_type": productItemType == null ? '' : productItemType,
        "ext_cost": extCost == null ? '' : extCost,
        "case_cost": caseCost == null ? '' : caseCost,
        "case_retail": caseRetail == null ? '' : caseRetail,
        "case_margin": caseMargin == null ? '' : caseMargin,
        "unit_cost": unitCost == null ? '' : unitCost,
        "purchase_price": purchasePrice == null ? '' : purchasePrice,
        "pp_without_discount":
            ppWithoutDiscount == null ? '' : ppWithoutDiscount,
        "discount_percent": discountPercent == null ? '' : discountPercent,
        "new_retail": newRetail == null ? '' : newRetail,
        "current_retail": currentRetail == null ? '' : currentRetail,
        "purchase_line_tax_id":
            purchaseLineTaxId == null ? '' : purchaseLineTaxId,
        "item_tax": itemTax == null ? '' : itemTax,
        "purchase_price_inc_tax":
            purchasePriceIncTax == null ? '' : purchasePriceIncTax,
        "profit_percent": profitPercent == null ? '' : profitPercent,
        "default_sell_price": defaultSellPrice == null ? '' : defaultSellPrice,
      };
}
