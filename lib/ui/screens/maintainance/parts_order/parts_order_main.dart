import 'dart:convert';

import 'package:dummy_app/data/models/maintainance/part_order/part_order.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';

import 'package:dummy_app/ui/screens/maintainance/parts_order/part_order_update.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/parts_order_add.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/parts_order_when_schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartsOrderMainScreen extends StatefulWidget {
  static const routeName = '/PartsOrderMainScreen';
  const PartsOrderMainScreen({
    Key? key,
    required this.showAppBar,
  }) : super(key: key);
  final bool showAppBar;
  @override
  _PartsOrderMainScreenState createState() => _PartsOrderMainScreenState();
}

class _PartsOrderMainScreenState extends State<PartsOrderMainScreen>
    with AutomaticKeepAliveClientMixin<PartsOrderMainScreen> {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _listScrollPage = ScrollController();
  List<PartOrderDatum> items = [];
  bool loading = false, allLoaded = false;
  int pageNo = 1;
  late PartsArguments? args;
  mockFetch() async {
    if (allLoaded) {
      return;
    }
    if (!mounted) return;
    setState(() {
      loading = true;
    });
    // await Future.delayed(const Duration(milliseconds: 500));
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    final responseString = await MaintainanceApiFunction()
        .getOrderParts(locationId.toString(), token, pageNo);
    final dummyList = partCategoryModelFromJson(responseString);
    // final jsonDecodeofResponse = json.decode(responseString);
    // final convertTomodelMachine = jsonDecodeofResponse['data'];

    // dummyList.data.data = List<PartOrderDatum>.from(
    //     convertTomodelMachine.map((x) => PartOrderDatum.fromJson(x)));

    final newList = dummyList.data.data;

    if (newList.isNotEmpty) {
      if (!mounted) return;
      setState(() {
        pageNo++;
        for (var item in newList) {
          items.add(item);
        }
      });
    }
    if (!mounted) return;
    setState(() {
      loading = false;
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
    if (widget.showAppBar) {
      setState(() {
        args = ModalRoute.of(context)!.settings.arguments as PartsArguments;
      });
    }
    super.build(context);
    return Scaffold(
      // appBar: widget.showAppBar
      //     ? AppBar(
      //         elevation: 1,
      //         title: Text(
      //           "Parts Order",
      //           style: Theme.of(context).textTheme.headline6,
      //         ),
      //       )
      //     : null,
      floatingActionButton: FloatingActionButton(
        heroTag: PartsOrderMainScreen.routeName,
        elevation: 0.0,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
        backgroundColor: buttonColor,
        onPressed: () {
          Navigator.of(context).pushNamed(
            AddPartOrderScreen.routeName,
            arguments: widget.showAppBar ? args : null,
          );
        },
      ),
      // appBar:  null,
      body: LayoutBuilder(
        builder: (context, constraits) {
          if (items.isNotEmpty) {
            return Stack(
              children: [
                ListView.separated(
                    controller: _listScrollPage,
                    itemBuilder: (context, index) {
                      if (index < items.length) {
                        return ListTile(
                          // isThreeLine: true,
                          // leading: CircleAvatar(
                          //   child: Text('$index'),
                          // ),
                          onTap: () {
                            // if (index == 1) {
                            //   Navigator.of(context).pushNamed(
                            //     UpdatePartOrderWhenSchedule.routeName,
                            //     arguments: items[index],
                            //   );
                            // } else {
                            Navigator.of(context).pushNamed(
                              UpdatePartOrderScreen.routeName,
                              arguments: items[index],
                            );
                            // }
                          },
                          title: Text("Name : ${items[index].orderName}"),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: '',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Part Category : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: items[index].partCateName),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Receive Date : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: formatofDateForView
                                            .format(items[index].recieveDate)),
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: items[index].status.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.forward,
                              color: buttonColor,
                            ),
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
                    itemCount: items.length + (allLoaded ? 1 : 0)),
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
          } else {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

class PartsArguments {
  bool partsArgumentsSchedule;
  PartsArguments(
    this.partsArgumentsSchedule,
  );
}
