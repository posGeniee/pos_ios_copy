import 'package:dummy_app/data/models/purchase_scan/purchases_list_api_model.dart'
    as data;
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/purchase_scan_api_function.dart';
import 'package:dummy_app/ui/screens/bulk_scan/bulk_scan_main.dart';
import 'package:dummy_app/ui/screens/puchase_scan/purchases_list_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseScanMain extends StatefulWidget {
  static const routeName = '/PurchaseScanMain';
  const PurchaseScanMain({Key? key}) : super(key: key);

  @override
  _PurchaseScanMainState createState() => _PurchaseScanMainState();
}

class _PurchaseScanMainState extends State<PurchaseScanMain> {
  @override
  Widget build(BuildContext context) {
    final signInModelData =
        Provider.of<AuthRequest>(context, listen: false).signiModelGetter;
    final locationId =
        Provider.of<AuthRequest>(context, listen: false).locationFromApiGetter;
    print("This is the Location Id $locationId");
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Purchase Scan",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(BulkScanMian.routeName);
            },
            icon: Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: FutureBuilder(
        builder: (context, snapshhot) {
          if (snapshhot.connectionState == ConnectionState.done) {
            final stringToJson =
                data.purchaseScanListApiDataFromMap(snapshhot.data.toString());
            if (stringToJson.message!.isNotEmpty) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      isThreeLine: true,
                      // leading: CircleAvatar(
                      //   child: Text('$index'),
                      // ),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          PurchaseListDetails.routeName,
                        );
                      },
                      title: RichText(
                        text: TextSpan(
                          text: '',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            const TextSpan(
                                text: 'Bank : ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: stringToJson
                                    .message![index].bank!.bankName),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text('${data.cateName} ${data.taxNumber}'),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Date : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: stringToJson
                                        .message![index].transactionDate
                                    // ' ${formatofDateForView.format(DateTime.now())}'
                                    ),
                              ],
                            ),
                          ),

                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Supplier : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: stringToJson
                                        .message![index].contact!.name),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Status : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: stringToJson.message![index].status),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // trailing: Column(
                      //   children: [
                      //     Text(double.parse(data.price).toStringAsFixed(2)),
                      //     Text(
                      //         '${double.parse(data.onHandQty).toStringAsFixed(2)} OnHand'),
                      //   ],
                      // ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: stringToJson.message!.length);
            } else if (stringToJson.message!.isEmpty) {
              return const Center(
                child: Text(
                  'No Data Found',
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: PurchaseScanApiFunction().listofPurchases(
            locationId.id.toString(), signInModelData.data!.bearer),
      ),
    );
  }
}



// import 'package:dummy_app/ui/screens/bulk_scan/bulk_scan_main.dart';
// import 'package:dummy_app/ui/screens/puchase_scan/purchases_list_details.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart' as datelibrary;

// class PurchaseScanMain extends StatefulWidget {
//   static const routeName = '/PurchaseScanMain';
//   const PurchaseScanMain({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _PurchaseScanMainState createState() => _PurchaseScanMainState();
// }

// class _PurchaseScanMainState extends State<PurchaseScanMain> {
//   final ScrollController _listScrollPage = ScrollController();
//   List<String> items = [];
//   bool loading = false, allLoaded = false;
//   final f = datelibrary.DateFormat('yyyy-MM-dd');

//   mockFetch() async {
//     if (allLoaded) {
//       return;
//     }
//     if (!mounted) return; setState(() {
//       loading = true;
//     });
//     await Future.delayed(const Duration(milliseconds: 500));
//     List<String> newData = items.length >= 60
//         ? []
//         : List.generate(20, (index) => "List Item ${index + items.length}");
//     if (newData.isNotEmpty) {
//       items.addAll(newData);
//     }
//     if (!mounted) return; setState(() {
//       loading = false;
//       allLoaded = newData.isEmpty;
//     });
//   }

//   @override
//   void initState() {
//     mockFetch();
//     _listScrollPage.addListener(() {
//       if (_listScrollPage.offset <= _listScrollPage.position.minScrollExtent &&
//           !_listScrollPage.position.outOfRange) {}
//       if (_listScrollPage.position.pixels >=
//               _listScrollPage.position.maxScrollExtent &&
//           !loading) {
//         print("this is the New Data Call----");
//         mockFetch();
//       }
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _listScrollPage.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         title: Text(
//           "Puchase Scan",
//           style: Theme.of(context).textTheme.headline6,
//         ),
//         actions: [
//           // IconButton(
//           //   onPressed: () {},
//           //   tooltip: 'Filters',
//           //   icon: Icon(
//           //     CupertinoIcons.settings,
//           //   ),
//           // ),
//           IconButton(
//             tooltip: 'Add Purchase',
//             onPressed: () {
//               Navigator.of(context).pushNamed(BulkScanMian.routeName);
//             },
//             icon: Icon(CupertinoIcons.add_circled),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(builder: (context, constraits) {
//         if (items.isNotEmpty) {
//           return Stack(
//             children: [
//               ListView.separated(
//                   controller: _listScrollPage,
//                   itemBuilder: (context, index) {
//                     if (index < items.length) {
//                       return ListTile(
//                         isThreeLine: true,
//                         leading: CircleAvatar(
//                           child: Text('$index'),
//                         ),
//                         onTap: () {
//                           Navigator.of(context).pushNamed(
//                             PurchaseListDetails.routeName,
//                           );
//                         },
//                         title: Text("PO2022/0013 : $index"),
//                         subtitle: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Text('${data.cateName} ${data.taxNumber}'),
//                             RichText(
//                               text: TextSpan(
//                                 text: '',
//                                 style: DefaultTextStyle.of(context).style,
//                                 children: <TextSpan>[
//                                   const TextSpan(
//                                       text: 'Date : ',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   TextSpan(
//                                       text: ' ${f.format(DateTime.now())}'),
//                                 ],
//                               ),
//                             ),

//                             RichText(
//                               text: TextSpan(
//                                 text: '',
//                                 style: DefaultTextStyle.of(context).style,
//                                 children: const <TextSpan>[
//                                   TextSpan(
//                                       text: 'Supplier : ',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   TextSpan(
//                                       text:
//                                           'LONESTAR WHOLESTAR AUSTIN BEVERAGE'),
//                                 ],
//                               ),
//                             ),
//                             RichText(
//                               text: TextSpan(
//                                 text: '',
//                                 style: DefaultTextStyle.of(context).style,
//                                 children: const <TextSpan>[
//                                   TextSpan(
//                                       text: 'Status : ',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   TextSpan(text: 'Recieved'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         // trailing: Column(
//                         //   children: [
//                         //     Text(double.parse(data.price).toStringAsFixed(2)),
//                         //     Text(
//                         //         '${double.parse(data.onHandQty).toStringAsFixed(2)} OnHand'),
//                         //   ],
//                         // ),
//                       );
//                     } else {
//                       return SizedBox(
//                         width: constraits.maxWidth,
//                         height: 50,
//                         child: const Center(
//                           child: Text("Nothing more to Load "),
//                         ),
//                       );
//                     }
//                   },
//                   separatorBuilder: (context, index) {
//                     return Divider(
//                       height: 1,
//                     );
//                   },
//                   itemCount: items.length + (allLoaded ? 1 : 0)),
//               if (loading) ...[
//                 Positioned(
//                   left: 0,
//                   bottom: 0,
//                   child: Container(
//                     height: 80,
//                     width: constraits.maxWidth,
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           );
//         } else {
//           return Container(
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }
//       }),
//     );
//   }
// }
