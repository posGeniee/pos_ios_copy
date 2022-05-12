import 'package:dummy_app/data/models/maintainance/parts/parts_model_list.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartsEditFieldModelSheet extends StatefulWidget {
  PartsEditFieldModelSheet({
    Key? key,
    this.categoryPartPicker,
    PartsListModelDatum? partsListModelDatum,
  })  : listModelDatum = (partsListModelDatum == null)
            ? PartsListModelDatum(
                image: '', name: '', note: '', id: 0, displayUrl: '')
            : partsListModelDatum,
        super(key: key);
  final void Function(PartsListModelDatum pickedCategory)? categoryPartPicker;
  final PartsListModelDatum? listModelDatum;

  @override
  State<PartsEditFieldModelSheet> createState() =>
      _PartsEditFieldModelSheetState();
}

class _PartsEditFieldModelSheetState extends State<PartsEditFieldModelSheet> {
  final ScrollController _listScrollPage = ScrollController();

  // List<CustomerListModelDatum>? items = [];
  PartsListModelDatum pickedCategory = PartsListModelDatum(
    image: '',
    name: '',
    note: '',
    id: 0,
    displayUrl: '',
  );
  List<PartsListModelDatum> items = [];
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
        .getParts(locationId.toString(), token, pageNo);
    final newList = partsListModelFromMap(responseString).data!.data;
    if (newList!.isNotEmpty) {
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
                "Select Part",
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
                                  items[index].name,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                trailing: (items[index].id ==
                                        widget.listModelDatum!.id)
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
