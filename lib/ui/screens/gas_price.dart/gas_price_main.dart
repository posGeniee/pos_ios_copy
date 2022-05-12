import 'package:dummy_app/data/models/gas_price/gas_price_api_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/gas_price_api_function.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:date_picker_timeline_trendway/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as datelibrary;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class GasPriceMainScreen extends StatefulWidget {
  static const routeName = '/GasPriceMainScreen';
  const GasPriceMainScreen({Key? key}) : super(key: key);

  @override
  _GasPriceMainScreenState createState() => _GasPriceMainScreenState();
}

class _GasPriceMainScreenState extends State<GasPriceMainScreen> {
  var isLoading = true;
  late GasPriceApiModel _detailModel;
  DateTime dateCalender = DateTime.now();
  final f = datelibrary.DateFormat('yyyy-MM-dd');
  String _selectedDate = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (!mounted) return; setState(() {
      if (args.value is DateTime) {
        _selectedDate = f.format(args.value);
        dateCalender = args.value;
        isLoading = true;
      }
    });
    Navigator.of(context).pop();
    // getSalesData(args.value);
    getSalesSummaryDetailsData(context);
  }

  getSalesSummaryDetailsData(BuildContext context) async {
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    await Future.delayed(Duration.zero);
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as DatumSaleSummaryModelApi;

    final result = await GasPriceApiFunction().getGasPrice(
        token,
        locationId.toString(),
        '${dateCalender.year}-${dateCalender.month}-${dateCalender.day}');
    if (result.runtimeType == String) {
      final saleDataModelofApi = gasPriceApiModelFromMap(result);

      if (!mounted) return; setState(() {
        isLoading = false;
        _detailModel = saleDataModelofApi;
      });
    }
  }

  @override
  void initState() {
    print('Init Runs --');
    getSalesSummaryDetailsData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Gas Price",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                builder: (BuildContext _) {
                  return Container(
                    height: 400,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Select the date",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SfDateRangePicker(
                          onSelectionChanged: _onSelectionChanged,
                          selectionMode: DateRangePickerSelectionMode.single,
                          initialSelectedRange: PickerDateRange(
                            DateTime.now().subtract(
                              const Duration(days: 4),
                            ),
                            DateTime.now().add(
                              const Duration(days: 3),
                            ),
                          ),
                        ),
                      ],
                      // alignment: WrapAlignment.center,
                    ),
                  );
                },
                isScrollControlled: true,
              );
            },
            icon: const Icon(CupertinoIcons.calendar),
          ),
        ],
      ),
      body: (isLoading)
          ? circularProgress
          : _detailModel.message!.isEmpty
              ? Container(
                  child: Center(child: Text('No Data Found')),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: DatePicker(
                        DateTime.now().subtract(Duration(days: 29)),
                        initialSelectedDate: dateCalender,
                        selectionColor: Colors.black,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          // New date selected
                          if (!mounted) return; setState(() {
                            _selectedDate = f.format(date);
                            dateCalender = date;
                            isLoading = true;
                          });
                          // getSalesData(date);
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return 
                            ListTile(
                              isThreeLine: true,
                              onTap: () async {},
                              title: RichText(
                                text: TextSpan(
                                  text: '',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Name : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: _detailModel.message![index].name,
                                      style:
                                          Theme.of(context).textTheme.headline6,
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
                                          text: 'Cost : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text:
                                              _detailModel.message![index].cost,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      ],
                                    ),
                                  ),
                                 
                                  RichText(
                                    text: TextSpan(
                                      text: '',
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Price : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: _detailModel
                                              .message![index].price,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: '',
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Gallon : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: _detailModel
                                              .message![index].gallon,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text(''),
                            );
                         
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1,
                            );
                          },
                          itemCount: _detailModel.message!.length),
                    ),
                  ],
                ),
    );
  }
}
