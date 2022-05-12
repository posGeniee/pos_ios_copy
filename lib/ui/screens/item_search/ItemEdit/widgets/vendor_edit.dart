import 'package:dummy_app/data/models/item%20search%20model/vendor_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/item_search_provider.dart';

import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/item_search_api_function.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VendorEditTextFormField extends StatefulWidget {
  static const routeName = '/VendorEditTextFormField';

  const VendorEditTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  _VendorEditTextFormFieldState createState() =>
      _VendorEditTextFormFieldState();
}

class _VendorEditTextFormFieldState extends State<VendorEditTextFormField> {
  final categoryName = TextEditingController(text: 'superadmin');

  @override
  Widget build(BuildContext context) {
    categoryName.text =
        Provider.of<ItemSearchProvider>(context).vendorSelectedGetter.supplier;
    return LayoutBuilder(
      builder: (context, constraits) {
        return TextFormField(
          readOnly: true,
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              builder: (BuildContext _) {
                return const ModelSheetofVendor();
              },
              isScrollControlled: true,
            );
          },
          controller: categoryName,
          decoration: const InputDecoration(
            hintText: 'None Selected',
            labelText: 'Search by Customer',
            suffixIcon: Icon(
              Icons.search,
              color: buttonColor,
            ),
          ),
        );
      },
    );
  }
}

class ToDoSearchDelegateofVendor extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
        // close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<dynamic>?>(
      future: search(context),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.length == 0) {
            return const Center(
              child: Text("No Data Found"),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].supplier),
                onTap: () {
                  // close(context, snapshot.data![index]);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Provider.of<ItemSearchProvider>(context, listen: false)
                      .changeselectedVendor(
                    DatumVendor(
                        supplier: snapshot.data![index].supplier,
                        id: snapshot.data![index].id),
                  );
                  // Navigator.of(context).pushNamed(
                  //   NewsDetailsPage.routeName,
                  //   arguments: snapshot.data![index],
                  // );
                },
              );
            },
            itemCount: snapshot.data!.length,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Future<List<dynamic>?> search(BuildContext context) async {
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final String data =
        await ItemSearchApiFuncion().searchVendors(query, token);

    final newList = vendorModelFromMap(data);

    return newList.message!.data;
  }
}

class ModelSheetofVendor extends StatefulWidget {
  const ModelSheetofVendor({
    Key? key,
  }) : super(key: key);

  @override
  State<ModelSheetofVendor> createState() => _ModelSheetofVendorState();
}

class _ModelSheetofVendorState extends State<ModelSheetofVendor> {
  final ScrollController _listScrollPage = ScrollController();
  final categoryName = TextEditingController(text: 'superadmin');
  // List<String> items = [];
  List<DatumVendor>? items = [];
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
    await Future.delayed(Duration.zero);
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;

    final responseString =
        await ItemSearchApiFuncion().getVendor(pageNo, token);

    final newList = vendorModelFromMap(responseString).message!.data;

    if (newList!.isNotEmpty) {
      if (!mounted) return;
      setState(() {
        pageNo++;
        for (var item in newList) {
          items!.add(item);
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
    _listScrollPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    categoryName.text = Provider.of<ItemSearchProvider>(context, listen: false)
        .vendorSelectedGetter
        .supplier;
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
                "Customer",
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
                    await showSearch(
                      context: context,
                      delegate: ToDoSearchDelegateofVendor(),
                    );
                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Please enter Customer',
                    labelText: 'Search by Customer',
                  ),
                  onFieldSubmitted: (value) {},
                ),
              ),
              if (items!.isNotEmpty)
                Expanded(
                  child: Stack(
                    children: [
                      ListView.separated(
                          controller: _listScrollPage,
                          itemBuilder: (context, index) {
                            if (index < items!.length) {
                              return ListTile(
                                leading: Text(
                                  items![index].id.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: Colors.white),
                                ),
                                title: Text(
                                  items![index].supplier.toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                trailing: (items![index].supplier ==
                                        categoryName.text)
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
                                    categoryName.text = items![index].supplier;
                                  });
                                  Provider.of<ItemSearchProvider>(context,
                                          listen: false)
                                      .changeselectedVendor(items![index]);
                                  Navigator.of(context).pop();
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
                          itemCount: items!.length + (allLoaded ? 1 : 0)),
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
