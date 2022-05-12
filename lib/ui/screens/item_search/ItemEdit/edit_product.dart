import 'package:dummy_app/data/models/item%20search%20model/department_model.dart';
import 'package:dummy_app/data/models/item%20search%20model/scan_bar_code.dart';
import 'package:dummy_app/data/models/item%20search%20model/search_products_with_plu_group&mixMatchModel.dart';
import 'package:dummy_app/data/models/item%20search%20model/vendor_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/item_search_provider.dart';
import 'package:dummy_app/helpers/helper%20function%20api/item_search_api_function.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/widgets/department_edit.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/widgets/tags_edit.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/widgets/vendor_edit.dart';
import 'package:dummy_app/ui/screens/item_search/plu_group_prod_graph.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_summary.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  static const routeName = '/EditProduct';
  const EditProduct({Key? key}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  void _showLoading() async {
    SmartDialog.showLoading(
      backDismiss: false,
    );
  }

  final lookUpUpc = TextEditingController(text: 'superadmin');
  final itemName = TextEditingController(text: 'superadmin');
  final vendorUpc = TextEditingController(text: 'superadmin');
  final price = TextEditingController(text: 'superadmin');
  final cost = TextEditingController(text: 'superadmin');
  final margin = TextEditingController(text: 'superadmin');
  final onHand = TextEditingController(text: 'superadmin');
  final packSize = TextEditingController(text: 'superadmin');
  final packUpc = TextEditingController(text: 'superadmin');
  final packPrice = TextEditingController(text: 'superadmin');

  final taxSize = TextEditingController(text: 'superadmin');
  final ebT = TextEditingController(text: 'superadmin');
  //Vendor  Name Missing
  final vendorName = TextEditingController(text: 'superadmin');
  final active = TextEditingController(text: 'superadmin');
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      final args =
          ModalRoute.of(context)!.settings.arguments as ScanBarCodeDatum;

      Provider.of<ItemSearchProvider>(context, listen: false)
          .changeselectedDepartment(
        DatumDepartment(
            name: (args.cateId == 0) ? 'null' : args.cateName, id: args.cateId),
      );
      Provider.of<ItemSearchProvider>(context, listen: false)
          .changeselectedVendor(
        DatumVendor(
          supplier: (args.vendorId == 0) ? 'null' : 'null',
          id: args.vendorId,
        ),
      );
      lookUpUpc.text = args.sku.toString();
      itemName.text = args.proName;

      price.text = double.parse(args.price).toStringAsFixed(2);
      cost.text = double.parse(args.cost).toStringAsFixed(2);
      margin.text = double.parse(args.margin).toStringAsFixed(2);
      packSize.text = args.packSize.toString();
      packUpc.text = args.packUpc.toString();
      packPrice.text = args.packPrice;
      taxSize.text = args.taxNumber;
      onHand.text = args.onHandQty;

      if (args.ebt == 1) {
        ebT.text = 'Yes';
      } else {
        ebT.text = 'No';
      }
      if (args.ebt == 1) {
        active.text = 'Yes';
      } else {
        active.text = 'No';
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    lookUpUpc.dispose();
    itemName.dispose();
    vendorUpc.dispose();
    price.dispose();
    cost.dispose();
    margin.dispose();
    onHand.dispose();
    packSize.dispose();
    packUpc.dispose();
    packPrice.dispose();

    taxSize.dispose();
    ebT.dispose();
    //Vendor  Name Missing
    vendorName.dispose();
    active.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScanBarCodeDatum;
    vendorUpc.text =
        Provider.of<ItemSearchProvider>(context).vendorSelectedGetter.supplier;

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
            icon: Icon(Icons.auto_graph_outlined),
          ),
          IconButton(
            onPressed: () async {
              print("The Save is Runing ---------------");
              // _showLoading();
              final departmentGetter =
                  Provider.of<ItemSearchProvider>(context, listen: false)
                      .departmentSelectedGetter;
              final vendorGetter =
                  Provider.of<ItemSearchProvider>(context, listen: false)
                      .vendorSelectedGetter;
              final token = Provider.of<AuthRequest>(context, listen: false)
                  .signiModelGetter
                  .data!
                  .bearer;
              await ItemSearchApiFuncion().saveProduct(
                catId: departmentGetter.id.toString(),
                cost: cost.text.toString(),
                eBT: (ebT.text == "Yes") ? 1.toString() : 0.toString(),
                name: itemName.text.toString(),
                netMargin: margin.text.toString(),
                onHandQty: onHand.text.toString(),
                packPrice: packPrice.text.toString(),
                packSize: packPrice.text.toString(),
                packUpc: packUpc.text.toString(),
                price: price.text.toString(),
                productId: args.id.toString(),
                productcode: args.productCode.toString(),
                sku: args.sku.toString(),
                taxNumber:
                    (taxSize.text == "TAX") ? 1.toString() : 0.toString(),
                vendorId: vendorGetter.id.toString(),
                token: token,
              );
              SmartDialog.dismiss();
              edgeAlert(
                context,
                backgroundColor: Colors.green,
                title: 'Product Saved Successfully',
              );
              Navigator.of(context).pop();
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
                fieldsubmited: () async {}, readOnly: false),
            appField(vendorUpc, 'Vendor UPC', TextInputType.emailAddress,
                TextInputAction.next,
                fieldsubmited: () async {}, readOnly: false),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: price,
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
                    decoration: const InputDecoration(
                      hintText: 'Price',
                      labelText: 'Price',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: cost,
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
                    decoration: const InputDecoration(
                      hintText: 'Cost',
                      labelText: 'Cost',
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: margin,
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
                  hintText: 'Margin',
                  labelText: 'Margin',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: onHand,
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
                    decoration: const InputDecoration(
                      hintText: 'On Hand',
                      labelText: 'On Hand',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: packSize,
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
                    decoration: const InputDecoration(
                      hintText: 'Pack Size',
                      labelText: 'Pack Size',
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
                padding: EdgeInsets.all(18),
                child: DepartmentEditTextForField()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: taxSize,

                    readOnly: true,
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
                                    if (!mounted) return;
                                    setState(() {
                                      taxSize.text = "TAX";
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
                                    if (!mounted) return;
                                    setState(() {
                                      taxSize.text = "NON TAX";
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
                      hintText: 'Tax',
                      labelText: 'Tax',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: ebT,
                    readOnly: true,
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
                                    if (!mounted) return;
                                    setState(() {
                                      ebT.text = "Yes";
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
                                    if (!mounted) return;
                                    setState(() {
                                      ebT.text = "No";
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
                      hintText: 'EBT',
                      labelText: 'EBT',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: packUpc,
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
                    decoration: const InputDecoration(
                      hintText: 'Pack UPC',
                      labelText: 'Pack UPC',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    controller: packPrice,
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
                    decoration: const InputDecoration(
                      hintText: 'Pack Price',
                      labelText: 'Pack Price',
                    ),
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.all(18),
              child: VendorEditTextFormField(),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: active,
                readOnly: true,
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
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              trailing: (active.text == "Yes")
                                  ? Icon(
                                      CupertinoIcons.check_mark_circled_solid,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      CupertinoIcons.checkmark,
                                      color: Colors.white,
                                    ),
                              onTap: () {
                                if (!mounted) return;
                                setState(() {
                                  active.text = "Yes";
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
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              trailing: (active.text == "No")
                                  ? Icon(
                                      CupertinoIcons.check_mark_circled_solid,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      CupertinoIcons.checkmark,
                                      color: Colors.white,
                                    ),
                              onTap: () {
                                if (!mounted) return;
                                setState(() {
                                  active.text = "No";
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
                  hintText: 'Active',
                  labelText: 'Active',
                ),
              ),
            ),
            // const Padding(
            //   padding: const EdgeInsets.all(18.0),
            //   child: TagEditFormField(),
            // ),
          ],
        ),
      ),
    );
  }
}
