import 'package:dummy_app/data/models/maintainance/parts/parts_model_list.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/ui/screens/maintainance/parts/parts_add.dart';
import 'package:dummy_app/ui/screens/maintainance/parts/update_part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartsMainScreen extends StatefulWidget {
  static const routeName = '/PartsMainScreen';
  const PartsMainScreen({Key? key}) : super(key: key);

  @override
  _PartsMainScreenState createState() => _PartsMainScreenState();
}

class _PartsMainScreenState extends State<PartsMainScreen>
    with AutomaticKeepAliveClientMixin<PartsMainScreen> {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _listScrollPage = ScrollController();
  List<PartsListModelDatum> items = [];
  bool loading = false, allLoaded = false;
  int pageNo = 1;

  mockFetch() async {
    if (allLoaded) {
      return;
    }
    if (!mounted) return; setState(() {
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
        .getParts(locationId.toString(), token, pageNo);
    final newList = partsListModelFromMap(responseString).data!.data;
    if (newList!.isNotEmpty) {
      if (!mounted) return; setState(() {
        pageNo++;
        for (var item in newList) {
          items.add(item);
        }
      });
    }
    if (!mounted) return; setState(() {
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
          heroTag: PartsMainScreen.routeName,
          elevation: 0.0,
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
          backgroundColor: buttonColor,
          onPressed: () {
            Navigator.of(context).pushNamed(PartsMainAddScreen.routeName);
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
                          isThreeLine: true,
                          leading: CircleAvatar(
                            child: items[index].displayUrl.isEmpty
                                ? Icon(CupertinoIcons.question)
                                : Image.network(items[index].displayUrl),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              UpdatePartScreen.routeName,
                              arguments: items[index],
                            );
                          },
                          title: RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Name : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: items[index].name),
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
                                        text: 'Notes : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: items[index].note),
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
