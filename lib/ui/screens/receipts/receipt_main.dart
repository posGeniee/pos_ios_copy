import 'package:dummy_app/data/models/receipts/receipt_list_api.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/receipt_scan_api_function.dart';
import 'package:dummy_app/ui/screens/receipts/receipt_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart' as datelibrary;

class ReceiptMain extends StatefulWidget {
  static const routeName = 'ReceiptMain';
  const ReceiptMain({Key? key}) : super(key: key);

  @override
  _ReceiptMainState createState() => _ReceiptMainState();
}

class _ReceiptMainState extends State<ReceiptMain> {
  var isLoading = true;
  DateTime dateCalender = DateTime.now();
  final f = datelibrary.DateFormat('yyyy-MM-dd');
  String _selectedDate = '';
  final ScrollController _listScrollPage = ScrollController();
  // List<String> items = [];
  List<ReceiptListApiDatum>? items = [];
  List<ReceiptListApiDatum>? itemsVoid = [];
  List<ReceiptListApiDatum>? itemsRefunds = [];
  List<ReceiptListApiDatum>? itemsNoSales = [];

  bool loading = false, allLoaded = false;
  int pageNo = 1;

  mockFetch() async {
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    print('Api Running--');
    if (allLoaded) {
      return;
    }

    if (!mounted) return;
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration.zero);

    final responseString = await ReceiptApiScan().getReciepts(
        token,
        pageNo.toString(),
        locationId.toString(),
        _selectedDate.isEmpty ? f.format(dateCalender) : _selectedDate);
    print("This is the Response ------------------ $responseString");
    final newList = receiptListApiFromMap(responseString).message!.data;

    if (newList!.isNotEmpty) {
      if (!mounted) return;
      setState(() {
        pageNo++;
      });
      for (var item in newList) {
        items!.add(item);
        if (item.status.contains('void')) {
          itemsVoid!.add(item);
        } else if (item.status.contains('Cancel')) {
          itemsRefunds!.add(item);
        } else if (item.status.contains('final')) {
          itemsNoSales!.add(item);
        }
      }
    }
    if (!mounted) return;
    setState(() {
      loading = false;
      allLoaded = (newList.isEmpty && pageNo > 1);
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (!mounted) return;
    setState(() {
      if (args.value is DateTime) {
        _selectedDate = f.format(args.value);
        dateCalender = args.value;
        print('Running --- $dateCalender');
        isLoading = true;
        items!.clear();
        pageNo = 1;
        print('Running --- $dateCalender');
        mockFetch();
      }
    });
    Navigator.of(context).pop();
    // getSalesData(args.value);
  }

  // getSalesData(DateTime date) async {
  //   final token = Provider.of<AuthRequest>(context, listen: false)
  //       .signiModelGetter
  //       .data!
  //       .bearer;
  //   final locationId = Provider.of<AuthRequest>(context, listen: false)
  //       .locationFromApiGetter
  //       .id;
  //   final result = await Provider.of<BusinessProvider>(context, listen: false)
  //       .getSalesGrpah(
  //     locationId.toString(),
  //     token,
  //     f.format(date),
  //   );
  //   final saleDataModelofApi =
  //       Provider.of<BusinessProvider>(context, listen: false)
  //           .saleOverViewModelGetter;
  //   if (!mounted) return; setState(() {
  //     isLoading = false;
  //     saleOverViewModel = saleDataModelofApi;
  //     _selectedDate = f.format(date);
  //   });
  // }
  @override
  void initState() {
    mockFetch();
    _listScrollPage.addListener(() {
      if (_listScrollPage.offset <= _listScrollPage.position.minScrollExtent &&
          !_listScrollPage.position.outOfRange) {}
      if (_listScrollPage.position.pixels >=
              _listScrollPage.position.maxScrollExtent &&
          !loading) {
        print("this is the New Data Call----");
        mockFetch();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _listScrollPage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(
            "Receipts ",
            style: Theme.of(context).textTheme.headline6,
          ),
          bottom: TabBar(
            indicatorColor: buttonColor,
            tabs: <Widget>[
              Tab(
                icon: Text(
                  'All',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Tab(
                icon: Text(
                  'Void',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Tab(
                icon: Text(
                  'Refunds',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Tab(
                icon: Text(
                  'No Sales',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          actions: [
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
        body: TabBarView(
          children: <Widget>[
            LayoutBuilder(
              builder: (context, constraits) {
                if (items!.isNotEmpty) {
                  return Stack(
                    children: [
                      ListView.separated(
                          controller: _listScrollPage,
                          itemBuilder: (context, index) {
                            if (index < items!.length) {
                              return ListTile(
                                isThreeLine: true,
                                leading: CircleAvatar(
                                  child: Text((items![index].type)),
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    ReceiptDetail.routeName,
                                    arguments: items![index],
                                  );
                                },
                                title: Text(items![index].receipts),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text('${data.cateName} ${data.taxNumber}'),
                                    Text(
                                        'Time: ${items![index].time!.hour} : ${items![index].time!.minute}'),
                                    Text('Reg : ${items![index].reg}'),
                                    Text(
                                        'Empolyee : ${items![index].employee}'),
                                  ],
                                ),
                                trailing: Column(children: [
                                  Text('Total : ${items![index].total}'),
                                ]),
                              );
                            } else {
                              return SizedBox(
                                width: constraits.maxWidth,
                                height: 50,
                                child: const Center(
                                  child: Text("Nothing more to Load "),
                                ),
                              );
                            }
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1,
                            );
                          },
                          itemCount: items!.length + (allLoaded ? 1 : 0)),
                      if (loading) ...[
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                            height: 80,
                            width: constraits.maxWidth,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                } else if (items!.isEmpty && loading == false) {
                  return Center(child: Text('No Data Found'));
                } else {
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
            Center(
              child: (itemsVoid!.isEmpty)
                  ? Text("No Data Found")
                  : ListView.separated(
                      controller: _listScrollPage,
                      itemBuilder: (context, index) {
                        if (index < itemsVoid!.length) {
                          return ListTile(
                            isThreeLine: true,
                            leading: CircleAvatar(
                              child: Text((itemsVoid![index].type)),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ReceiptDetail.routeName,
                                arguments: itemsVoid![index],
                              );
                            },
                            title: Text(itemsVoid![index].receipts),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${data.cateName} ${data.taxNumber}'),
                                Text(
                                    'Time: ${itemsVoid![index].time!.hour} : ${itemsVoid![index].time!.minute}'),
                                Text('Reg : ${itemsVoid![index].reg}'),
                                Text(
                                    'Empolyee : ${itemsVoid![index].employee}'),
                              ],
                            ),
                            trailing: Column(children: [
                              Text('Total : ${itemsVoid![index].total}'),
                            ]),
                          );
                        } else {
                          return Text('');
                        }
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 1,
                        );
                      },
                      itemCount: itemsVoid!.length),
            ),
            Center(
              child: (itemsRefunds!.isEmpty)
                  ? Text("No Data Found")
                  : ListView.separated(
                      controller: _listScrollPage,
                      itemBuilder: (context, index) {
                        if (index < itemsRefunds!.length) {
                          return ListTile(
                            isThreeLine: true,
                            leading: CircleAvatar(
                              child: Text((itemsRefunds![index].type)),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ReceiptDetail.routeName,
                                arguments: itemsRefunds![index],
                              );
                            },
                            title: Text(itemsRefunds![index].receipts),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${data.cateName} ${data.taxNumber}'),
                                Text(
                                    'Time: ${itemsRefunds![index].time!.hour} : ${itemsRefunds![index].time!.minute}'),
                                Text('Reg : ${itemsRefunds![index].reg}'),
                                Text(
                                    'Empolyee : ${itemsRefunds![index].employee}'),
                              ],
                            ),
                            trailing: Column(children: [
                              Text('Total : ${itemsRefunds![index].total}'),
                            ]),
                          );
                        } else {
                          return Text('');
                        }
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 1,
                        );
                      },
                      itemCount: itemsRefunds!.length),
            ),
            Center(
              child: (itemsNoSales!.isEmpty)
                  ? Text("No Data Found")
                  : ListView.separated(
                      controller: _listScrollPage,
                      itemBuilder: (context, index) {
                        if (index < itemsNoSales!.length) {
                          return ListTile(
                            isThreeLine: true,
                            leading: CircleAvatar(
                              child: Text((itemsNoSales![index].type)),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ReceiptDetail.routeName,
                                arguments: itemsNoSales![index],
                              );
                            },
                            title: Text(itemsNoSales![index].receipts),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${data.cateName} ${data.taxNumber}'),
                                Text(
                                    'Time: ${itemsNoSales![index].time!.hour} : ${itemsNoSales![index].time!.minute}'),
                                Text('Reg : ${itemsNoSales![index].reg}'),
                                Text(
                                    'Empolyee : ${itemsNoSales![index].employee}'),
                              ],
                            ),
                            trailing: Column(children: [
                              Text('Total : ${itemsNoSales![index].total}'),
                            ]),
                          );
                        } else {
                          return Text('');
                        }
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 1,
                        );
                      },
                      itemCount: itemsNoSales!.length),
            ),
          ],
        ),
      ),
    );
  }
}
