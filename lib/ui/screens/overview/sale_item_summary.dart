import 'package:dummy_app/data/models/sale_summary_model.dart';
import 'package:dummy_app/data/models/sales_overview.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/business_provider.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/overview/overview_main.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleItemSummary extends StatefulWidget {
  static const routeName = '/SaleItemSummary';

  const SaleItemSummary({Key? key}) : super(key: key);

  @override
  _SaleItemSummaryState createState() => _SaleItemSummaryState();
}

class _SaleItemSummaryState extends State<SaleItemSummary> {
  var isLoading = true;
  late SaleSummaryModelApi saleSummary;
  getSalesSummaryData(BuildContext context) async {
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    await Future.delayed(Duration.zero);
    final args =
        ModalRoute.of(context)!.settings.arguments as NamedArgumentClass;
    // final date = formatofDateForView.format(args.dateTime as DateTime);
    // String dateString =
    //     '${args.dateTime!.year}-${args.dateTime!.month}-${args.dateTime!.day}';
    final result = await Provider.of<BusinessProvider>(context, listen: false)
        .getSalesSummary(locationId.toString(), args.data.id.toString(), token,
            args.dateTime, args.type);
    final saleDataModelofApi =
        Provider.of<BusinessProvider>(context, listen: false)
            .saleSummaryModelApiGetter;
    if (!mounted) return;
    setState(() {
      isLoading = false;
      saleSummary = saleDataModelofApi;
    });
  }

  @override
  void initState() {
    getSalesSummaryData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Item Summary",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: (isLoading)
          ? circularProgress
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: DataTable(
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
                        'Item Name',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Sales',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Share',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: [
                    // for (var item in
                    //     saleSummary.data!.data!
                    //     )
                    for (var item = 0;
                        item < saleSummary.data!.data!.length;
                        item++)
                      DataRow(
                        onSelectChanged: (newValue) async {
                          // await Provider.of<BusinessProvider>(context,
                          //         listen: false)
                          //     .changeCategorId(item.itemName);
                          Navigator.of(context).pushNamed(
                            SaleItemDetail.routeName,
                            arguments: saleSummary.data!.data![item],
                          );
                        },
                        cells: [
                          DataCell(
                            Text(double.parse(saleSummary.data!.data![item].qty)
                                .toStringAsFixed(0)),
                          ),
                          DataCell(
                            Text(
                              saleSummary.data!.data![item].itemName,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                          DataCell(
                            Text(double.parse(
                                        saleSummary.data!.data![item].totalPaid)
                                    .toStringAsFixed(2) +
                                '\$'),
                          ),
                          DataCell(
                            Text(saleSummary.data!.data![item].share
                                    .toStringAsFixed(1) +
                                "%"),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ScreenArguments {
  final String title;

  ScreenArguments(this.title);
}

String stringdata = '''{
    "code": 200,
    "message": "Successfully data",
    "data": {
        "current_page": 1,
        "data": [
            {
                "product_id": 337215,
                "qty": "1.0000",
                "item_name": "Blk Rfle Espresso Cream",
                "total_paid": "4.4500",
                "share": 8.4320227380388441673630950390361249446868896484375
            },
            {
                "product_id": 337216,
                "qty": "1.0000",
                "item_name": "Blk Rfle Espresso Mocha",
                "total_paid": "4.4500",
                "share": 8.4320227380388441673630950390361249446868896484375
            },
            {
                "product_id": 337224,
                "qty": "1.0000",
                "item_name": "CAPPUCCINO MID",
                "total_paid": "43.8750",
                "share": 83.135954523922322323414846323430538177490234375
            }
        ],
        "first_page_url": "https://thesuperstarshop.com/api/v2/item-summary?page=1",
        "from": 1,
        "last_page": 1,
        "last_page_url": "https://thesuperstarshop.com/api/v2/item-summary?page=1",
        "links": [
            {
                "url": null,
                "label": "&laquo; Previous",
                "active": false
            },
            {
                "url": "https://thesuperstarshop.com/api/v2/item-summary?page=1",
                "label": "1",
                "active": true
            },
            {
                "url": null,
                "label": "Next &raquo;",
                "active": false
            }
        ],
        "next_page_url": null,
        "path": "https://thesuperstarshop.com/api/v2/item-summary",
        "per_page": 10,
        "prev_page_url": null,
        "to": 3,
        "total": 3
    }
}''';
