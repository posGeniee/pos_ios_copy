// import 'package:date_picker_timeline_trendway/date_picker_timeline.dart';
import 'package:dummy_app/data/models/over_view/clock_time_model.dart';
import 'package:dummy_app/data/models/over_view/inventory_model.dart';
import 'package:dummy_app/helpers/helper%20function%20api/over_view_scan_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/ui/screens/overview/registerer/registerer_main.dart';
import 'package:intl/intl.dart' as datelibrary;

import 'package:dummy_app/data/models/sales_overview.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/business_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/overview/app_pie_chart_widget.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class OverViewMain extends StatefulWidget {
  static const routeName = '/OverViewMain';
  const OverViewMain({Key? key}) : super(key: key);

  @override
  _OverViewMainState createState() => _OverViewMainState();
}

class _OverViewMainState extends State<OverViewMain> {
  var isLoading = true;
  late SaleOverViewModel saleOverViewModel;
  DateTime dateCalender = DateTime.now();
  final f = datelibrary.DateFormat('yyyy-MM-dd');
  String _selectedDate = '';
  bool selectedToday = true;
  bool selectedWeekly = false;
  bool selectedMonthly = false;

  bool selectedYearly = false;
  bool selectedDateRange = false;
  String typeOverAll = 'today';
  double percentTotal = 0;
  double amountTotal = 0;

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
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
    print('On Selected Runs-------');
    if (!mounted) return;
    setState(() {
      // if (args.value is PickerDateRange) {
      //   _range = '${f.format(args.value.startDate)} -'
      //       // ignore: lines_longer_than_80_chars
      //       ' ${f.format(args.value.endDate ?? args.value.startDate)}';
      // } else
      if (args.value is DateTime) {
        _selectedDate = f.format(args.value);
        dateCalender = args.value;
        isLoading = true;
        print('Date Used : $dateCalender');
        Navigator.of(context).pop();
        getSalesData(_selectedDate, typeOverAll);
      } else if (args.value is PickerDateRange) {
        print(args.value);
        final dataReturned = args.value as PickerDateRange;
        if (dataReturned.endDate != null && dataReturned.startDate != null) {
          isLoading = true;
          _selectedDate =
              'start_date=${f.format(dataReturned.startDate as DateTime)}&end_date=${f.format(dataReturned.endDate as DateTime)}';

          Navigator.of(context).pop();
          getSalesData(_selectedDate, 'range-date');
        }
        // _dateCount = args.value.length.toString();
      }
      // else {
      //   _rangeCount = args.value.length.toString();
      // }
    });
  }

  getSalesData(String date, String type) async {
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    final result = await Provider.of<BusinessProvider>(context, listen: false)
        .getSalesGrpah(
      locationId.toString(),
      token,
      date,
      type,
    );
    final saleDataModelofApi =
        Provider.of<BusinessProvider>(context, listen: false)
            .saleOverViewModelGetter;

    if (!mounted) return;
    setState(() {
      isLoading = false;
      saleOverViewModel = saleDataModelofApi;
      _selectedDate = date;
      typeOverAll = type;
    });
    if (saleOverViewModel.data!.isNotEmpty) {
      amountTotal = 0.0;
      saleOverViewModel.data!.map((e) {
        amountTotal = amountTotal + e.totalPaid;
        return null;
      }).toList();
      print('Total Amount : $amountTotal');
      saleOverViewModel.data!.map((e) {
        e.amountinPrecent = e.totalPaid / amountTotal * 100;
        return null;
      });
    }
  }

  @override
  void initState() {
    setState(() {
      selectedToday = true;
    });
    getSalesData(f.format(DateTime.now()), 'today');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final menuItem = Provider.of<BusinessProvider>(
      context,
    ).saleNewMenuItem;
    final token = Provider.of<AuthRequest>(
      context,
    ).signiModelGetter.data!.bearer;
    final locationId = Provider.of<AuthRequest>(
      context,
    ).locationFromApiGetter.id;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          menuItem.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          if (menuItem.title.contains('Sales') &&
              menuItem.title.characters.length == 5)
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
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
                            initialSelectedDate: dateCalender,
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
                    return Container(
                      child: Wrap(
                        children: [
                          for (var item in listofSalesItems)
                            ListTile(
                              leading: Text(
                                '1'.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white),
                              ),
                              title: Text(
                                item.title,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              trailing: (item.title == menuItem.title)
                                  ? const Icon(
                                      CupertinoIcons.check_mark_circled_solid,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      CupertinoIcons.checkmark,
                                      color: Colors.white,
                                    ),
                              onTap: () {
                                Provider.of<BusinessProvider>(context,
                                        listen: false)
                                    .changeMenuItem(item);
                                print('This is Running -- ');
                                final menuItem2 = Provider.of<BusinessProvider>(
                                        context,
                                        listen: false)
                                    .saleNewMenuItem;
                                if (menuItem2.title.contains('Sales') &&
                                    menuItem2.title.characters.length == 5) {
                                  print('item ${menuItem2.title}');
                                  setState(() {
                                    isLoading = true;
                                  });
                                  getSalesData(_selectedDate, typeOverAll);
                                }
                                if (menuItem2.title
                                    .contains('Clock Ins/Void/Sales')) {
                                  // print('item ${menuItem2.title}');
                                  // setState(() {
                                  //   isLoading = true;
                                  // });
                                  // getSalesData(_selectedDate, typeOverAll);
                                }

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
              icon: const Icon(
                CupertinoIcons.ellipsis_circle_fill,
                color: Colors.green,
                size: 18,
              ),
              label: Text(
                "",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ],
      ),
      body: (isLoading)
          ? circularProgress
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (menuItem.title.contains('Sales') &&
                      menuItem.title.characters.length == 5)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Selected Date : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: f.format(dateCalender)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ChoiceChip(
                                  label: const Text("Today"),
                                  selected: selectedToday,
                                  onSelected: (bool value) {
                                    // if (selectedToday = true) {
                                    // } else {
                                    setState(() {
                                      selectedToday = value;
                                      selectedWeekly = false;
                                      selectedMonthly = false;
                                      selectedYearly = false;
                                      selectedDateRange = false;
                                      _selectedDate = f.format(DateTime.now());
                                      isLoading = true;
                                    });
                                    getSalesData(_selectedDate, "today");
                                    print(selectedToday);
                                    // }
                                    print(selectedToday);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ChoiceChip(
                                  label: const Text("Weekly"),
                                  selected: selectedWeekly,
                                  onSelected: (bool value) {
                                    print(_selectedDate);
                                    setState(() {
                                      //   // _selectedDate = f.format(DateTime.now());
                                      isLoading = true;
                                      selectedToday = false;
                                      selectedWeekly = value;
                                      selectedMonthly = false;
                                      selectedYearly = false;
                                      selectedDateRange = false;
                                    });
                                    getSalesData(_selectedDate, "weekly");
                                    // print(selectedWeekly);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ChoiceChip(
                                  label: const Text("Monthly"),
                                  selected: selectedMonthly,
                                  onSelected: (bool value) {
                                    setState(() {
                                      selectedToday = false;
                                      selectedWeekly = false;
                                      selectedMonthly = value;
                                      selectedYearly = false;
                                      selectedDateRange = false;
                                      // _selectedDate = f.format(DateTime.now());
                                      isLoading = true;
                                    });
                                    getSalesData(_selectedDate, "monthly");
                                    print(selectedMonthly);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ChoiceChip(
                                  label: const Text("Yearly"),
                                  selected: selectedYearly,
                                  onSelected: (bool value) {
                                    setState(() {
                                      // _selectedDate = f.format(DateTime.now());
                                      isLoading = true;
                                      selectedToday = false;
                                      selectedWeekly = false;
                                      selectedMonthly = false;
                                      selectedYearly = value;
                                      selectedDateRange = false;
                                    });
                                    print(selectedYearly);
                                    getSalesData(_selectedDate, "yearly");
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ChoiceChip(
                                  label: const Text("Date Range"),
                                  selected: selectedDateRange,
                                  onSelected: (bool value) {
                                    setState(() {
                                      selectedToday = false;
                                      selectedWeekly = false;
                                      selectedMonthly = false;
                                      selectedYearly = false;
                                      selectedDateRange = value;
                                    });
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(30)),
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
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SfDateRangePicker(
                                                onSelectionChanged:
                                                    _onSelectionChanged,
                                                selectionMode:
                                                    DateRangePickerSelectionMode
                                                        .extendableRange,
                                                initialSelectedDate:
                                                    dateCalender,
                                              ),
                                            ],
                                            // alignment: WrapAlignment.center,
                                          ),
                                        );
                                      },
                                      isScrollControlled: true,
                                    );
                                    // selectedDateRange = value;
                                    // setState(() {});
                                    // print(selectedDateRange);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (saleOverViewModel.data!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                text: '',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  const TextSpan(
                                      text:
                                          'Total Business Without Scan & Go : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: '$amountTotal \$'),
                                ],
                              ),
                            ),
                          ),
                        if (saleOverViewModel.data!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                text: '',
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: 'Scan & Go : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: '0 \$'),
                                ],
                              ),
                            ),
                          ),
                        if (saleOverViewModel.data!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                text: '',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Total Business : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: '$amountTotal \$'),
                                ],
                              ),
                            ),
                          ),
                        if (saleOverViewModel.data!.isNotEmpty)
                          AppPieChartWidget(
                            saleData: [
                              for (var item in saleOverViewModel.data!)
                                SalesData(
                                  item.name,
                                  item.totalPaid,
                                ),
                            ],
                          ),
                        if (saleOverViewModel.data!.isNotEmpty)
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: DataTable(
                                columnSpacing: 10.0,
                                showCheckboxColumn: false,
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      'Department',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Sales',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Share',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                                rows: [
                                  for (var item in saleOverViewModel.data!)
                                    DataRow(
                                      onSelectChanged: (newValue) async {
                                        await Provider.of<BusinessProvider>(
                                                context,
                                                listen: false)
                                            .changeCategorId(item.id);
                                        if (!mounted) return;
                                        setState(() {
                                          item.dateTime = dateCalender;
                                        });
                                        print(
                                            'This is the Date We are Sending --$dateCalender ');
                                        Navigator.of(context).pushNamed(
                                          SaleItemSummary.routeName,
                                          arguments: NamedArgumentClass(
                                              _selectedDate, item, typeOverAll),
                                        );
                                      },
                                      cells: [
                                        DataCell(
                                          Text(item.name),
                                        ),
                                        DataCell(
                                          Text(item.totalPaid
                                                  .toStringAsFixed(2) +
                                              '\$'),
                                        ),
                                        DataCell(
                                          Text(item.share.toStringAsFixed(2) +
                                              "%"),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        if (saleOverViewModel.data!.isEmpty)
                          Center(
                            child: Text(
                              "No Data Found",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: buttonColor),
                            ),
                          ),
                      ],
                    ),
                  if (menuItem.title.contains('Clock Ins/Void/Sales'))
                    FutureBuilder(
                        future: OverViewScanApiFunction()
                            .getClockInVoid(token, locationId.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            String inventoryString = snapshot.data.toString();
                            print(inventoryString);
                            ClockInModelOverView data =
                                clockInModelOverViewFromMap(inventoryString);
                            if (data.data!.isEmpty) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: Center(
                                  child: Text(
                                    'No Data Found',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: buttonColor),
                                  ),
                                ),
                              );
                            } else {
                              return SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: DataTable(
                                    columnSpacing: 60.0,
                                    showCheckboxColumn: false,
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          'Employee Name',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Status',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Time In (First)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Time Out (Last)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Voids',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Receipts',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Lines',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                    rows: [
                                      for (var item in data.data!)
                                        DataRow(
                                          onSelectChanged: (newValue) async {
                                            // await Provider.of<BusinessProvider>(context,
                                            //         listen: false)
                                            //     .changeCategorId(item.itemName);
                                            // Navigator.of(context).pushNamed(
                                            //   SaleItemDetail.routeName,
                                            //   arguments: item,
                                            // );
                                          },
                                          cells: [
                                            DataCell(
                                              Text(item.employeeName as String),
                                            ),
                                            DataCell(
                                              Text(item.status as String),
                                            ),
                                            DataCell(
                                              Text(
                                                formatofDateForViewwithTime
                                                    .format(item.clockInTime
                                                        as DateTime),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                formatofDateForViewwithTime
                                                    .format(item.clockOutTime
                                                        as DateTime),
                                              ),
                                            ),
                                            DataCell(
                                              Text(item.voids.toString()),
                                            ),
                                            DataCell(
                                              Text(item.receipts.toString()),
                                            ),
                                            DataCell(
                                              Text(item.lines.toString()),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: Center(child: circularProgress));
                          }
                          return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Center(child: circularProgress));
                        }),
                  if (menuItem.title.contains('Registers'))
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: const [
                          RegistererMainWidget(),
                          Card(
                            child: ExpansionTile(
                              title: Text('ExpansionTile 1'),
                              subtitle: Text('Trailing expansion arrow icon'),
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    'This is tile number 1',
                                  ),
                                  trailing: Text('data'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (menuItem.title.contains('Inventory'))
                    FutureBuilder(
                        future: OverViewScanApiFunction()
                            .getInventory(token, locationId.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            String inventoryString = snapshot.data.toString();
                            print(inventoryString);
                            InventoryModelOverView data =
                                inventoryModelOverViewFromMap(inventoryString);
                            if (data.data.data.isEmpty) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: Center(
                                  child: Text(
                                    'No Data Found',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: buttonColor),
                                  ),
                                ),
                              );
                            } else {
                              return SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: DataTable(
                                    columnSpacing: 60.0,
                                    showCheckboxColumn: false,
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          'Department',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Live',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Book',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Name',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Stock',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Unit Price',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                    rows: [
                                      for (var item in data.data.data)
                                        DataRow(
                                          onSelectChanged: (newValue) async {
                                            // await Provider.of<BusinessProvider>(context,
                                            //         listen: false)
                                            //     .changeCategorId(item.itemName);
                                            // Navigator.of(context).pushNamed(
                                            //   SaleItemDetail.routeName,
                                            //   arguments: item,
                                            // );
                                          },
                                          cells: [
                                            const DataCell(
                                              Text('Gocery'),
                                            ),
                                            DataCell(
                                              Text(
                                                  item.live.toStringAsFixed(2)),
                                            ),
                                            DataCell(
                                              Text(item.book),
                                            ),
                                            DataCell(
                                              Text(item.name),
                                            ),
                                            DataCell(
                                              Text(item.stock),
                                            ),
                                            DataCell(
                                              Text(
                                                double.parse(item.unitPrice)
                                                        .toStringAsFixed(2) +
                                                    ' \$',
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: Center(child: circularProgress));
                          }
                          return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Center(child: circularProgress));
                        }),
                ],
              ),
            ),
    );
  }
}

class NamedArgumentClass {
  final String dateTime;
  final Datum data;
  final String type;

  NamedArgumentClass(this.dateTime, this.data, this.type);
}

// Widget _buildChip(String label, Color color,) {
//   return Padding(
//     padding: EdgeInsets.all(5),
//     child: Chip(
//       labelPadding: EdgeInsets.all(2.0),
//       avatar: CircleAvatar(
//         backgroundColor: Colors.white70,
//         child: Text(label[0].toUpperCase()),
//       ),
//       label: Text(
//         label,
//         style: TextStyle(
//           color: Colors.white,
//         ),
//       ),
//       backgroundColor: color,
//       elevation: 6.0,
//       shadowColor: Colors.grey[60],
//       padding: EdgeInsets.all(8.0),
//     ),
//   );
// }
