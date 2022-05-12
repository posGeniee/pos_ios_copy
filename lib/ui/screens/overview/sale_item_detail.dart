import 'package:dummy_app/data/models/over_view/over_view_item_detail.dart';
import 'package:dummy_app/data/models/sale_summary_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/over_view_scan_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleItemDetail extends StatefulWidget {
  static const routeName = '/SaleItemDetail';
  const SaleItemDetail({Key? key}) : super(key: key);

  @override
  _SaleItemDetailState createState() => _SaleItemDetailState();
}

class _SaleItemDetailState extends State<SaleItemDetail> {
  var isLoading = true;
  late OverViewItemDetailModel _detailModel;
  getSalesSummaryDetailsData(BuildContext context) async {
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    await Future.delayed(Duration.zero);
    final args =
        ModalRoute.of(context)!.settings.arguments as DatumSaleSummaryModelApi;

    final result = await OverViewScanApiFunction()
        .getItemDetail(token, locationId.toString(), args.productId.toString());
    if (result.runtimeType == String) {
      final saleDataModelofApi = overViewItemDetailFromMap(result);

      if (!mounted) return; setState(() {
        isLoading = false;
        _detailModel = saleDataModelofApi;
      });
    }
  }

  @override
  void initState() {
    getSalesSummaryDetailsData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Item Detail",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: (isLoading)
          ? circularProgress
          : _detailModel.data!.isEmpty
              ? Container(
                  child: Text('No Data Found'),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Recipt Id : ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: _detailModel.data![0].receipt,
                              style: Theme.of(context).textTheme.headline6,
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
                              text: 'Recipt Quantity : ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: _detailModel.data![0].qty,
                              style: Theme.of(context).textTheme.headline6,
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
                                text: 'Reciept Time : ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: formatofDateForView.format(
                                _detailModel.data![0].time as DateTime,
                              ),
                              style: Theme.of(context).textTheme.headline6,
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
                              text: 'Reciept Price : ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: _detailModel.data![0].price,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
