import 'package:dummy_app/data/models/maintainance/schedule/trips/decision/decision_list.dart';
import 'package:dummy_app/data/models/maintainance/schedule/trips/trip_list.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/decisions/decision_update.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/decisions/decisions_add.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/ticket_trip_add.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/ticket_trip_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DecisionMainScreen extends StatefulWidget {
  static const routeName = '/DecisionMainScreen';
  const DecisionMainScreen({Key? key}) : super(key: key);

  @override
  _DecisionMainScreenState createState() => _DecisionMainScreenState();
}

class _DecisionMainScreenState extends State<DecisionMainScreen>
    with AutomaticKeepAliveClientMixin<DecisionMainScreen> {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _listScrollPage = ScrollController();
  List<DecisionModelDatum> items = [];
  bool loading = false, allLoaded = false, apiLoading = true;
  int pageNo = 1;

  mockFetch() async {
    await Future.delayed(const Duration(seconds: 0));
    if (allLoaded) {
      return;
    }
    if (!mounted) return;
    setState(() {
      loading = true;
    });
    // await Future.delayed(const Duration(milliseconds: 500));
    // List<String> newData = items.length >= 60
    //     ? []
    //     : List.generate(20, (index) => "List Item ${index + items.length}");
    // if (newData.isNotEmpty) {
    //   items.addAll(newData);
    // }
    final args = ModalRoute.of(context)!.settings.arguments as TripModelDatum;
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    final responseString = await MaintainanceApiFunction()
        .getDecisions(locationId.toString(), token, pageNo, args.id.toString());
    print(responseString);
    final newList = decisionListModelFromMap(responseString).data!.data;
    if (newList!.isNotEmpty) {
      if (!mounted) return;
      setState(() {
        pageNo++;
        for (var item in newList) {
          items.add(item);
        }
      });
    } else if (newList.isEmpty) {
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
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
        backgroundColor: buttonColor,
        onPressed: () {
          final args =
              ModalRoute.of(context)!.settings.arguments as TripModelDatum;
          Navigator.of(context).pushNamed(
            AddDecision.routeName,
            arguments: args,
          );
        },
      ),
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Decisions",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
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
                          // leading: CircleAvatar(
                          //   child: Text('$index'),
                          // ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              UpdateDecisionScreen.routeName,
                              arguments: items[index],
                            );
                          },
                          title:
                              Text("Description : ${items[index].description}"),
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
