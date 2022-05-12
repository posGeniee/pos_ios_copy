import 'package:dummy_app/data/models/item%20search%20model/scan_bar_code.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/item_search_api_function.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/edit_product.dart';
import 'package:dummy_app/ui/screens/item_search/plu_group_prod_graph.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginationExample extends StatefulWidget {
  static const routeName = '/PaginationExample';
  const PaginationExample({
    Key? key,
  }) : super(key: key);

  @override
  _PaginationExampleState createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample> {
  final ScrollController _listScrollPage = ScrollController();
  // List<String> items = [];
  List<ScanBarCodeDatum>? items = [];
  bool loading = false, allLoaded = false;
  int pageNo = 1;
  bool isLoadingCall = true;

  mockFetch() async {
    if (allLoaded) {
      return;
    }
    if (!mounted) return;
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration.zero);

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final responseString = await ItemSearchApiFuncion()
        .searchFromProductName(args.title, pageNo, token);
    print("This is the Response ------------------ $responseString");
    final newList = scanBarCodeFromMap(responseString).message!.data;
    // List<String> newData = items!.length >= 60
    //     ? []
    //     : List.generate(20,
    //         (index) => "List Item  ${args.title}+ ${index + items!.length}");
    if (newList!.isNotEmpty) {
      // items!.addAll(newList);
      if (!mounted) return;
      setState(() {
        pageNo++;
      });
      for (var item in newList) {
        items!.add(item);
      }
    }
    if (!mounted) return;
    setState(() {
      loading = false;
      isLoadingCall = false;
      allLoaded = newList.isEmpty;
    });
  }

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
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search: ${args.title}',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: LayoutBuilder(
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
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              EditProduct.routeName,
                              arguments: items![index],
                            );
                          },
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
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: items![index].proName,
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                          ),
                          // Text(items![index].proName),
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
                                    TextSpan(
                                      text: 'Prod. Code : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: items![index].productCode,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
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
                                      text: 'Dept : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: items![index].productCode,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Graph : ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          PluGroupProdGraph.routeName,
                                          arguments: ScreenArguments(
                                              '${items![index].id}'),
                                        );
                                      },
                                      icon: const Icon(Icons.auto_graph)),
                                ],
                              )
                            ],
                          ),
                          trailing: Column(
                            children: [
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
                                      text: (double.parse(items![index].price)
                                          .toStringAsFixed(2)),
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
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
                                      text: 'OnHand : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          double.parse(items![index].onHandQty)
                                              .toStringAsFixed(2),
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    )
                                  ],
                                ),
                              ),
                              // Text(
                              //     '${double.parse(items![index].onHandQty).toStringAsFixed(2)} OnHand'),
                            ],
                          ),
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
          } else if (items!.isEmpty && isLoadingCall == false) {
            return Center(child: Text('No Data Found'));
          } else {
            return Container(
              child: Center(child: circularProgress),
            );
          }
        },
      ),
    );
  }
}








// class PaginationExample extends StatefulWidget {
//   final String searchString;
//   const PaginationExample({Key? key, required this.searchString})
//       : super(key: key);

//   @override
//   _PaginationExampleState createState() => _PaginationExampleState();
// }

// class _PaginationExampleState extends State<PaginationExample> {
//   final ScrollController _listScrollPage = ScrollController();
//   List<String> items = [];
//   bool loading = false, allLoaded = false;

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
//         title: Text('Page View Scrolling'),
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
//                           // Navigator.of(context).pushNamed(
//                           //   EditProduct.routeName,
//                           //   arguments: data,
//                           // );
//                         },
//                         title: Text("data.proName ${items[index]}"),
//                         subtitle: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Text('${data.cateName} ${data.taxNumber}'),
//                             Text("data.productCode"),
//                             Text('Dept : '),
//                             Text('Flags: '),
//                             IconButton(
//                                 onPressed: () {
//                                   // Navigator.of(context)
//                                   //     .pushNamed(PluGroupProdGraph.routeName);
//                                 },
//                                 icon: Icon(Icons.auto_graph)),
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
