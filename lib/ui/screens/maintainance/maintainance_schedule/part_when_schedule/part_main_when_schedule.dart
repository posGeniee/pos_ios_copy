import 'dart:convert';

import 'package:dummy_app/data/models/maintainance/part_order/part_order.dart';
import 'package:dummy_app/data/models/maintainance/schedule/schedule_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/part_when_schedule/part_add_when_schedule.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/part_when_schedule/update_parts_when_schedule.dart';

import 'package:dummy_app/ui/screens/maintainance/parts_order/part_order_update.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/parts_order_add.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/parts_order_when_schedule.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartMainScreenWhenSchedule extends StatefulWidget {
  static const routeName = '/PartMainScreenWhenSchedule';
  const PartMainScreenWhenSchedule({
    Key? key,
    required this.args,
  }) : super(key: key);
  final ScheduleModelDatum args;
  @override
  _PartMainScreenWhenScheduleState createState() =>
      _PartMainScreenWhenScheduleState();
}

class _PartMainScreenWhenScheduleState extends State<PartMainScreenWhenSchedule>
    with AutomaticKeepAliveClientMixin<PartMainScreenWhenSchedule> {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _listScrollPage = ScrollController();
  List<PartOrderDatum> items = [];
  bool loading = false, allLoaded = false, apiLoading = true;
  int pageNo = 1;

  late Animation<double> _animation;
  late AnimationController _animationController;
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
    final responseString = await MaintainanceApiFunction().getPartsWhenSchedule(
      locationId.toString(),
      token,
      pageNo,
      widget.args.id.toString(),
    );
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
    } else if (newList.isEmpty) {
      if (!mounted) return;
      setState(() {
        apiLoading = false;
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
    super.build(context);
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 1,
      //   title: Text(
      //     "Parts",
      //     style: Theme.of(context).textTheme.headline6,
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        heroTag: PartMainScreenWhenSchedule.routeName,
        elevation: 0.0,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
        backgroundColor: buttonColor,
        onPressed: () {
          final args =
              ModalRoute.of(context)!.settings.arguments as ScheduleModelDatum;
          Navigator.of(context).pushNamed(
            PartsMainAddScreenWhenScedule.routeName,
            arguments: args,
          );
        },
      ),
      // floatingActionButton:
      // FloatingActionBubble(
      //   // Menu items
      //   items: <Bubble>[
      //     // Floating action menu item
      //     Bubble(
      //       title: "Part Order",
      //       iconColor: Colors.red,
      //       bubbleColor: buttonColor,
      //       icon: Icons.add,
      //       titleStyle: TextStyle(fontSize: 16, color: Colors.white),
      //       onPress: () {
      //         // final args = ModalRoute.of(context)!.settings.arguments
      //         //     as DoubleScreenArguments;
      //         // _animationController.reverse();
      //         // configureAlertOfApp(context, () async {
      //         //   showLoading();
      //         //   final token =
      //         //       Provider.of<AuthRequest>(context, listen: false)
      //         //           .signiModelGetter
      //         //           .data!
      //         //           .bearer;
      //         //   print(args.reportFullPath.id.toString());
      //         //   final responseString =
      //         //       await MaintainanceApiFunction().deleteTrip(
      //         //     args.reportFullPath.id.toString(),
      //         //     token,
      //         //   );
      //         //   if (responseString.runtimeType == String) {
      //         //     // Provider.of<MaintainanceProvider>(context, listen: false)
      //         //     //     .removeIndividualForMainScreebListModelDatumSetter(
      //         //     //         args);
      //         //     Navigator.of(context).pop();
      //         //     Navigator.of(context).pop();
      //         //     Navigator.of(context).pop();
      //         //   }
      //         //   dismissLoading();
      //         // });
      //       },
      //     ),
      //     //Floating action menu item
      //     Bubble(
      //       title: "Parts",
      //       iconColor: Colors.white,
      //       bubbleColor: buttonColor,
      //       icon: Icons.add,
      //       titleStyle: TextStyle(fontSize: 16, color: Colors.white),
      //       onPress: () {
      //         // final args = ModalRoute.of(context)!.settings.arguments
      //         //     as DoubleScreenArguments;
      //         // _animationController.reverse();
      //         // Navigator.of(context).pushNamed(
      //         //   DecisionMainScreen.routeName,
      //         //   arguments: args.reportFullPath,
      //         // );
      //       },
      //     ),
      //   ],

      //   // animation controller
      //   animation: _animation,

      //   // On pressed change animation state
      //   onPress: () => _animationController.isCompleted
      //       ? _animationController.reverse()
      //       : _animationController.forward(),

      //   // Floating Action button Icon color
      //   iconColor: Colors.white,

      //   // Flaoting Action button Icon
      //   iconData: Icons.edit,
      //   backGroundColor: buttonColor,
      // ),
      // // appBar:  null,
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
                            Navigator.of(context).pushNamed(
                              PartsMainUpdateScreenWhenScedule.routeName,
                              arguments: items[index],
                            );
                            // } else {
                            //   Navigator.of(context).pushNamed(
                            //     UpdatePartOrderScreen.routeName,
                            //     arguments: items[index],
                            //   );
                            // }
                          },
                          // title: Text("Name : ${items[index].id}"),
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
                                        text: 'Part : ',
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
                                        text: 'Warrenty Date : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: formatofDateForView.format(
                                            items[index].partWarrantyDate)),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Description : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: items[index]
                                            .description
                                            .toString()),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Cost : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: items[index].cost.toString()),
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
          } else if (apiLoading == false && items.isEmpty) {
            return Container(child: Center(child: Text('No Data Found')));
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
