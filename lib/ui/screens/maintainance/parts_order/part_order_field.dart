import 'package:dummy_app/data/models/maintainance/part_category/part_category_list.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/maintainance_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartsCategoryEditFieldModelSheet extends StatefulWidget {
  const PartsCategoryEditFieldModelSheet({Key? key, this.categoryPartPicker})
      : super(key: key);
  final void Function(PartCategoryDatum pickedCategory)? categoryPartPicker;

  @override
  State<PartsCategoryEditFieldModelSheet> createState() =>
      _PartsCategoryEditFieldModelSheetState();
}

class _PartsCategoryEditFieldModelSheetState
    extends State<PartsCategoryEditFieldModelSheet> {
  final ScrollController _listScrollPage = ScrollController();
   PartCategoryDatum pickedCategory =  PartCategoryDatum(
      id: 0,
      businessId: 0,
      locationId: "0",
      name: '',
      profit: '0',
      createdBy: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());
  // List<CustomerListModelDatum>? items = [];
  List<PartCategoryDatum> items = [];
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
        .getPartCategory(locationId.toString(), token, pageNo);
    final newList = partCategoryModelFromJson(responseString).data.data;
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
        // mockFetch();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _listScrollPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // categoryName.text =
    //     Provider.of<MaintainanceProvider>(context, listen: false)
    //         .selectedCustomerListModelDatumGetter
    //         .fullName;
    return LayoutBuilder(builder: (context, constraits) {
      return StatefulBuilder(builder:
          (BuildContext context, StateSetter setter /*You can rename this!*/) {
        return SizedBox(
          height: 400,
          child: Column(
            children: [
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width * 2,
              ),
              Text(
                "Select Part Category",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width * 2,
              ),
              if (items.isNotEmpty)
                Expanded(
                  child: Stack(
                    children: [
                      ListView.separated(
                          controller: _listScrollPage,
                          itemBuilder: (context, index) {
                            if (index < items.length) {
                              return ListTile(
                                leading: Text(
                                  items[index].id.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: Colors.white),
                                ),
                                title: Text(
                                  items[index].name.toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                trailing: (items[index].id == pickedCategory.id)
                                    ? const Icon(
                                        CupertinoIcons.check_mark_circled_solid,
                                        color: Colors.green,
                                      )
                                    : const Icon(
                                        CupertinoIcons.checkmark,
                                        color: Colors.white,
                                      ),
                                onTap: () {
                                  if (!mounted) return;
                                  setState(() {
                                    // if (pickedCategory == null) {
                                    // } else {
                                    // widget.categoryPartPicker!(
                                    //   PartCategoryDatum(
                                    //       id: 0,
                                    //       businessId: 0,
                                    //       locationId: "0",
                                    //       name: '',
                                    //       profit: '0',
                                    //       createdBy: 0,
                                    //       createdAt: DateTime.now(),
                                    //       updatedAt: DateTime.now()),
                                    // );
                                    pickedCategory = items[index];

                                    widget.categoryPartPicker!(items[index]);
                                    Navigator.of(context).pop();
                                    // }
                                  });
                                  // Provider.of<MaintainanceProvider>(context,
                                  //         listen: false)
                                  //     .addSelectedCustomerListModelDatumSetter(
                                  //         items![index]);
                                  // Navigator.of(context).pop();
                                },
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
                  ),
                )
              else
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      });
    });
  }
}
