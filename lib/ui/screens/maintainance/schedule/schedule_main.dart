import 'package:dummy_app/data/models/maintainance/schedule/schedule_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/ui/screens/maintainance/schedule/schedule_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleMainScreen extends StatefulWidget {
  static const routeName = '/ScheduleMainScreen';
  const ScheduleMainScreen({Key? key}) : super(key: key);

  @override
  _ScheduleMainScreenState createState() => _ScheduleMainScreenState();
}

class _ScheduleMainScreenState extends State<ScheduleMainScreen>
    with AutomaticKeepAliveClientMixin<ScheduleMainScreen> {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _listScrollPage = ScrollController();
  List<ScheduleModelDatum> items = [];
  bool loading = false, allLoaded = false;
  int pageNo = 1;
  mockFetch() async {
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
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    final responseString = await MaintainanceApiFunction()
        .getSchedules(locationId.toString(), token, pageNo);
    final newList = scheduleModelFromJson(responseString).data.data;
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
  Widget build(
    BuildContext context,
  ) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: ScheduleMainScreen.routeName,
          elevation: 0.0,
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
          backgroundColor: buttonColor,
          onPressed: () {
            Navigator.of(context).pushNamed(ScheduleAdd.routeName);
          }),
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
                            configureAlertOfApp(context, () async {
                              showLoading();
                              final token = Provider.of<AuthRequest>(context,
                                      listen: false)
                                  .signiModelGetter
                                  .data!
                                  .bearer;
                              final locationId = Provider.of<AuthRequest>(
                                      context,
                                      listen: false)
                                  .locationFromApiGetter
                                  .id;
                              final responseString =
                                  await MaintainanceApiFunction()
                                      .deleteSchedule(
                                items[index].machine,
                                token,
                                locationId.toString(),
                              );
                              if (responseString.runtimeType == String) {
                                // Provider.of<MaintainanceProvider>(context, listen: false)
                                //     .removeIndividualForMainScreebListModelDatumSetter(args);
                                // Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }
                              dismissLoading();
                            });
                          },
                          title: RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Machine Name : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: items[index].machine),
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
                                    const TextSpan(
                                        text: 'Date : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: formatofDateForView
                                          .format(items[index].date),
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
                                        text: 'Created By : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: items[index].createdBy,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(
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
                      return const Divider(
                        height: 1,
                      );
                    },
                    itemCount: items.length + (allLoaded ? 1 : 0)),
                if (loading) ...[
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: SizedBox(
                      height: 80,
                      width: constraits.maxWidth,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
