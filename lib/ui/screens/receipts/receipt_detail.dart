import 'package:dummy_app/data/models/receipts/receipt_detail_api.dart';
import 'package:dummy_app/data/models/receipts/receipt_list_api.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/receipt_scan_api_function.dart';
import 'package:dummy_app/helpers/widget.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as datelibrary;
import 'package:provider/provider.dart';

class ReceiptDetail extends StatefulWidget {
  static const routeName = '/ReceiptDetail';
  const ReceiptDetail({Key? key}) : super(key: key);

  @override
  State<ReceiptDetail> createState() => _ReceiptDetailState();
}

class _ReceiptDetailState extends State<ReceiptDetail> {
  final f = datelibrary.DateFormat('yyyy-MM-dd');
  var isLoading = true;
  late ReceiptDetailApi _receiptDetailApi;

  apiDataFetch() async {
    await Future.delayed(const Duration(seconds: 0));
    final args =
        ModalRoute.of(context)!.settings.arguments as ReceiptListApiDatum;
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final String responseString =
        await ReceiptApiScan().receiptDetails(token, args.receipts);
    final responseObject = receiptDetailApiFromMap(responseString);
    if (!mounted) return;
    setState(() {
      isLoading = false;
      _receiptDetailApi = responseObject;
    });
  }

  @override
  void initState() {
    apiDataFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ReceiptListApiDatum;
    final locationId =
        Provider.of<AuthRequest>(context, listen: false).locationFromApiGetter;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Preview",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: isLoading == false
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Text(
                      'Business Name: ${locationId.name}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: buttonColor),
                    ),
                    Text(
                      'Receipt No. ${args.receipts}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: buttonColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Date: ${f.format(
                        DateTime(
                          args.time!.year,
                          args.time!.month,
                          args.time!.day,
                        ),
                      )} ',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: buttonColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Register No. ${args.reg}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: buttonColor, fontWeight: FontWeight.bold),
                    ),
                    if (isLoading == false) ...[
                      DataTable(
                        columnSpacing: 38.0,
                        showCheckboxColumn: false,
                        columns: [
                          DataColumn(
                            label: Text(
                              'Qty',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Description',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Amount',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: [
                          for (var item in _receiptDetailApi.message!)
                            DataRow(
                              onSelectChanged: (newValue) async {
                                // await Provider.of<BusinessProvider>(context,
                                //         listen: false)
                                //     .changeCategorId(item.id);
                                // Navigator.of(context).pushNamed(
                                //   SaleItemSummary.routeName,
                                // );
                              },
                              cells: [
                                DataCell(
                                  Text(double.parse(item.qty)
                                      .toStringAsFixed(2)),
                                ),
                                DataCell(
                                  Text(item.name),
                                ),
                                DataCell(
                                  Text(double.parse(item.amount)
                                      .toStringAsFixed(2)),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Tax : 0.0 ',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: buttonColor),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Total : ${_receiptDetailApi.total.toStringAsFixed(2)} \$",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: buttonColor),
                      ),
                    ]
                  ],
                ),
              ),
            )
          : Center(child: circularProgress),
    );
  }
}
