import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/business_provider.dart';
import 'package:dummy_app/data/network/item_search_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/ui/screens/item_search/plu_group_detail_prod_screen.dart';
import 'package:dummy_app/ui/screens/item_search/widgets/search_delegate_of_plu_group.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PluGroupWidget extends StatefulWidget {
  const PluGroupWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PluGroupWidget> createState() => _PluGroupWidgetState();
}

class _PluGroupWidgetState extends State<PluGroupWidget> {
  final ScrollController plugroupscrollController = ScrollController();
  bool isPopularEnd = false;
  bool isLoading = true;
  bool allLoaded = false;

  callPluGroupList() async {
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    await Provider.of<ItemSearchProvider>(context, listen: false)
        .pluGroupApiCall(
      locationId.toString(),
      token,
    )
        .then((value) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      dismissLoading();
    });

    plugroupscrollController.addListener(() {
      if (plugroupscrollController.offset <=
              plugroupscrollController.position.minScrollExtent &&
          !plugroupscrollController.position.outOfRange) {}
      if (plugroupscrollController.position.pixels >=
              plugroupscrollController.position.maxScrollExtent &&
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
        .data!.bearer;
    final data = await Provider.of<ItemSearchProvider>(context, listen: false)
        .pluGroupListCall(locationId.toString(),token);
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
    Future.delayed(const Duration(milliseconds: 500), () {
      showLoading();
      if (Provider.of<ItemSearchProvider>(context, listen: false)
          .pluGroupListGetter!
          .isNotEmpty) {
        Provider.of<ItemSearchProvider>(context, listen: false).emptyPluGroup();
      }
    });
    callPluGroupList();
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
                      "Plu Group",
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
                            delegate: ToDoSearchDelegateofPluGroup(),
                          );
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Please enter Plu Group',
                          labelText: 'Search by Plu Group',
                        ),
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                    if (Provider.of<ItemSearchProvider>(context)
                        .pluGroupListGetter!
                        .isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          controller: plugroupscrollController,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            print(
                                "Thi si the Length of List ${Provider.of<ItemSearchProvider>(context).pluGroupListGetter!.length}");
                            final getData =
                                Provider.of<ItemSearchProvider>(context)
                                    .pluGroupListGetter;
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
                                  PluGroupProductScreen.routeName,
                                  arguments: ScreenArguments(
                                    getData[index].id.toString(),
                                  ),
                                );
                              },
                            );
                          },
                          itemCount: Provider.of<ItemSearchProvider>(context)
                              .pluGroupListGetter!
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
        labelText: 'Search by Plu Group',
        suffixIcon: Icon(
          Icons.search,
          color: buttonColor,
        ),
      ),
    );
  }
}
