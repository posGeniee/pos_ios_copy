import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/item_search_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/ui/screens/item_search/mix_match_group_prod_screen.dart';
import 'package:dummy_app/ui/screens/item_search/widgets/search_delegate_of_mix_match_group.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MixMatchGroupWidget extends StatefulWidget {
  const MixMatchGroupWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MixMatchGroupWidget> createState() => _MixMatchGroupWidgetState();
}

class _MixMatchGroupWidgetState extends State<MixMatchGroupWidget> {
  final ScrollController mixMatchscrollController = ScrollController();
  bool isPopularEnd = false;
  bool isLoading = true;
  bool allLoaded = false;

  mixMatchGroupList() async {
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    await Provider.of<ItemSearchProvider>(context, listen: false)
        .mixMatchGroupListcall(locationId.toString(), token)
        .then((value) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      dismissLoading();
    });

    mixMatchscrollController.addListener(() {
      if (mixMatchscrollController.offset <=
              mixMatchscrollController.position.minScrollExtent &&
          !mixMatchscrollController.position.outOfRange) {}
      if (mixMatchscrollController.position.pixels >=
              mixMatchscrollController.position.maxScrollExtent &&
          !isPopularEnd) {
        nextPageCall();
      }
    });
  }

  nextPageCall() async {
    if (allLoaded) {
      return;
    }
    if (!mounted) return;
    setState(() {
      isPopularEnd = true;
    });
    print('Next Page Call---');
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final data = await Provider.of<ItemSearchProvider>(context, listen: false)
        .mixMatchGroupListcall(locationId.toString(), token);
    if (data == 'No Data Found') {
      print("This si the runsingljlfsf s");
      if (!mounted) return;
      setState(() {
        allLoaded = true;
        isPopularEnd = false;
      });
    } else {
      if (!mounted) return;
      setState(() {
        isPopularEnd = false;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      showLoading();
      if (Provider.of<ItemSearchProvider>(context, listen: false)
          .mixMatchGroupListGetter!
          .isNotEmpty) {
        Provider.of<ItemSearchProvider>(context, listen: false)
            .emptyMixMstchGroup();
      }
    });
    mixMatchGroupList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locationFromApiBusiness = Provider.of<AuthRequest>(
      context,
    ).locationFromApiGetter;
    return TextFormField(
      readOnly: true,
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          builder: (BuildContext _) {
            return StatefulBuilder(builder: (BuildContext context,
                StateSetter setState /*You can rename this!*/) {
              return SizedBox(
                height: 400,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 2,
                    ),
                    Text(
                      "Mix & Match Group",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async {
                          final toDo = await showSearch(
                            context: context,
                            delegate: ToDoSearchDelegateofMixMatchGroup(),
                          );
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Please enter Mix & Match Group',
                          labelText: 'Search by Mix & Match Group',
                        ),
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                    if (Provider.of<ItemSearchProvider>(context)
                        .mixMatchGroupListGetter!
                        .isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          controller: mixMatchscrollController,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            print(
                                "Thi si the Length of List ${Provider.of<ItemSearchProvider>(context).mixMatchGroupListGetter!.length}");
                            final getData =
                                Provider.of<ItemSearchProvider>(context)
                                    .mixMatchGroupListGetter;
                            return ListTile(
                              leading: Text(
                                getData![index].id.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white),
                              ),
                              title: Text(
                                getData[index].name,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              trailing: (getData[index].name ==
                                      locationFromApiBusiness.name)
                                  ? const Icon(
                                      CupertinoIcons.check_mark_circled_solid,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      CupertinoIcons.checkmark,
                                      color: Colors.white,
                                    ),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed(
                                    MixMatchProdScreen.routeName,
                                    arguments: ScreenArguments(
                                        getData[index].id.toString()));
                              },
                            );
                          },
                          itemCount: Provider.of<ItemSearchProvider>(context)
                              .mixMatchGroupListGetter!
                              .length,
                        ),
                      )
                    else
                      (Provider.of<ItemSearchProvider>(context)
                              .pluGroupListGetter!
                              .isEmpty)
                          ? Text('No Data Found')
                          : CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 2,
                    ),
                  ],
                ),
              );
            });
          },
          isScrollControlled: true,
        );
      },
      decoration: const InputDecoration(
        hintText: 'None Selected',
        labelText: 'Search by Mix-Match Group',
        suffixIcon: Icon(
          Icons.search,
          color: buttonColor,
        ),
      ),
    );
  }
}
