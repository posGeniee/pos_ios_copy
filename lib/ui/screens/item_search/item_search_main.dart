import 'package:dummy_app/data/models/item%20search%20model/scan_bar_code.dart';
import 'package:dummy_app/data/models/item%20search%20model/search_products_with_plu_group&mixMatchModel.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/item_search_api_function.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/edit_product.dart';
import 'package:dummy_app/ui/screens/item_search/bar_code_scanner_widget.dart';
import 'package:dummy_app/ui/screens/item_search/options/add_mix_match_group.dart';
import 'package:dummy_app/ui/screens/item_search/options/add_plu_group.dart';
import 'package:dummy_app/ui/screens/item_search/pagination_example.dart';

import 'package:dummy_app/ui/screens/item_search/widgets/mix_match_group_widget.dart';
import 'package:dummy_app/ui/screens/item_search/widgets/plu_group_widget.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_summary.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ItemSearchMainPage extends StatefulWidget {
  static const routeName = '/ItemSearchMainPage';
  const ItemSearchMainPage({Key? key}) : super(key: key);

  @override
  State<ItemSearchMainPage> createState() => _ItemSearchMainPageState();
}

class _ItemSearchMainPageState extends State<ItemSearchMainPage> {
  final barCodeId = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final barCodeName = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();

  void _showLoading() async {
    SmartDialog.showLoading(
      backDismiss: false,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Item Search',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton.icon(
              onPressed: () async {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
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
                            'Add Plu Group',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AddPluGroup.routeName);
                          },
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
                            'Add Mix Match Group',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AddMixMatchGroup.routeName);
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
                'Options',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  // await [
                  //   Permission.camera,
                  // ].request();
                  // final requestAccessCamera = await Permission.camera.isGranted;
                  // if (requestAccessCamera) {
                    Navigator.of(context).pushNamed(ScannerScreen.routeName);
                  // }
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
                    } else {
                      final newData = response.message!.data![0];
                      Navigator.of(context).pushNamed(
                        EditProduct.routeName,
                        arguments: newData,
                      );
                      SmartDialog.dismiss();
                    }
                  }
                },
              ),
            ),
            Form(
              key: _formKey1,
              child: TextFormField(
                controller: barCodeName,
                // readOnly: readOnly,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Product name';
                  }

                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Please enter Product name',
                  labelText: 'Search by Product name',
                ),

                onFieldSubmitted: (value) async {
                  if (_formKey1.currentState!.validate() == true) {
                    Navigator.of(context).pushNamed(PaginationExample.routeName,
                        arguments: ScreenArguments(barCodeName.text));
                  }
                },
              ),
            ),
            Text(
              '--------- Group Search ---------',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: buttonColor, fontWeight: FontWeight.bold),
            ),
            const PluGroupWidget(),
            const MixMatchGroupWidget(),
          ],
        ),
      ),
    );
  }
}
