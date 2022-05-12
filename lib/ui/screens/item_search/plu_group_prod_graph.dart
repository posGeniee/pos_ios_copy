import 'package:dummy_app/data/models/item%20search%20model/sales_of_7_15_30_days.dart';
import 'package:dummy_app/data/network/auth_request.dart';

import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/item_search_api_function.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart' as datelibrary;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PluGroupProdGraph extends StatefulWidget {
  static const routeName = '/PluGroupProdGraph';
  const PluGroupProdGraph({Key? key}) : super(key: key);

  @override
  _PluGroupProdGraphState createState() => _PluGroupProdGraphState();
}

class _PluGroupProdGraphState extends State<PluGroupProdGraph> {
  late GetSalesof7D15D30DModel _salesof7d15d30dModel;
  bool _isLoading = true;
  List<ChartSampleData>? chartData;
  DateTime dateCalender = DateTime.now();
  final f = datelibrary.DateFormat('yyyy-MM-dd');
  String _selectedDate = '';
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    if (!mounted) return; setState(() {
      // if (args.value is PickerDateRange) {
      //   _range = '${f.format(args.value.startDate)} -'
      //       // ignore: lines_longer_than_80_chars
      //       ' ${f.format(args.value.endDate ?? args.value.startDate)}';
      // } else
      if (args.value is DateTime) {
        _selectedDate = f.format(args.value);
        dateCalender = args.value;
        _isLoading = true;
      }
      // else if (args.value is List<DateTime>) {
      //   _dateCount = args.value.length.toString();
      // } else {
      //   _rangeCount = args.value.length.toString();
      // }
    });
    Navigator.of(context).pop();
    getGraphData(args.value);
  }

  TooltipBehavior? _tooltipBehavior;
  List<StackedColumnSeries<ChartSampleData, String>> _getStackedColumnSeries() {
    return <StackedColumnSeries<ChartSampleData, String>>[
      StackedColumnSeries<ChartSampleData, String>(
          dataSource: chartData!,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Sales'),
      StackedColumnSeries<ChartSampleData, String>(
          dataSource: chartData!,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          name: 'Purchase'),
    ];
  }

  SfCartesianChart _buildStackedColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          labelFormat: '{value}',
          maximum: 30,
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getStackedColumnSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  getGraphData(DateTime date) async {
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    await Future.delayed(Duration.zero);
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final result = await ItemSearchApiFuncion().salesGraphofItemSearch(
        locationId.toString(),
        args.title,
        '${dateCalender.year}-${dateCalender.month}-${dateCalender.day}',
        token);
    if (result.runtimeType == String) {
      _salesof7d15d30dModel = getSalesof7D15D30DModelFromMap(result);
      chartData = <ChartSampleData>[
        ChartSampleData(
          x: '7 D',
          y: _salesof7d15d30dModel.message![0].sales!.the7Days,
          yValue: _salesof7d15d30dModel.message![1].purchases!.the7Days,
        ),
        ChartSampleData(
          x: '15 D',
          y: _salesof7d15d30dModel.message![0].sales!.the15Days,
          yValue: _salesof7d15d30dModel.message![1].purchases!.the15Days,
        ),
        ChartSampleData(
          x: '30 D',
          y: _salesof7d15d30dModel.message![0].sales!.the30Days,
          yValue: _salesof7d15d30dModel.message![1].purchases!.the30Days,
        ),
      ];
      if (!mounted) return; setState(() {
        _isLoading = false;
        // saleOverViewModel = saleDataModelofApi;
        _selectedDate = f.format(date);
      });
    }
  }

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    getGraphData(dateCalender);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Item Graph History',
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
      body: _isLoading
          ? circularProgress
          : Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Sales vs Purchases Comparision Table',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (_salesof7d15d30dModel.message!.isNotEmpty)
                  SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: 38.0,
                      showCheckboxColumn: false,
                      columns: [
                        DataColumn(
                          label: Text(
                            'Type',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            '7 D',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            '15 D',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            '30 D',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: [
                        DataRow(
                          onSelectChanged: (newValue) async {},
                          cells: [
                            DataCell(
                              Text('Sales'),
                            ),
                            DataCell(
                              Text(_salesof7d15d30dModel
                                  .message![0].sales!.the7Days
                                  .toStringAsFixed(0)),
                            ),
                            DataCell(
                              Text(_salesof7d15d30dModel
                                  .message![0].sales!.the15Days
                                  .toStringAsFixed(0)),
                            ),
                            DataCell(
                              Text(_salesof7d15d30dModel
                                  .message![0].sales!.the30Days
                                  .toStringAsFixed(0)),
                            ),
                          ],
                        ),
                        DataRow(
                          onSelectChanged: (newValue) async {},
                          cells: [
                            DataCell(
                              Text('Purchases'),
                            ),
                            DataCell(
                              Text(_salesof7d15d30dModel
                                  .message![1].purchases!.the7Days
                                  .toStringAsFixed(0)),
                            ),
                            DataCell(
                              Text(_salesof7d15d30dModel
                                  .message![1].purchases!.the15Days
                                  .toStringAsFixed(0)),
                            ),
                            DataCell(
                              Text(_salesof7d15d30dModel
                                  .message![1].purchases!.the30Days
                                  .toStringAsFixed(0)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (_salesof7d15d30dModel.message!.isEmpty)
                  Center(
                    child: Text(
                      "No Data Found",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: buttonColor),
                    ),
                  ),
                Expanded(child: Container()),
                Container(height: 300, child: _buildStackedColumnChart()),
                Expanded(child: Container()),
              ],
            ),
    );
  }
}

const _dataofthis = '''{
    "code": 200,
    "message": [
        {
            "sales": {
                "7-days": 10,
                "15-days": 15,
                "30-days": 27
            }
        },
        {
            "purchases": {
                "7-days": 10,
                "15-days": 15,
                "30-days": 25
            }
        }
    ]
}''';

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}

/// Chart Sales Data
class SalesData {
  /// Holds the datapoint values like x, y, etc.,
  SalesData(this.x, this.y, [this.date, this.color]);

  /// X value of the data point
  final dynamic x;

  /// y value of the data point
  final dynamic y;

  /// color value of the data point
  final Color? color;

  /// Date time value of the data point
  final DateTime? date;
}
