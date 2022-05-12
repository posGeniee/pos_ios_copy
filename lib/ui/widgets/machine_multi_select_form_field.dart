import 'package:dummy_app/data/models/maintainance/machines/machine_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/maintainance_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachineEditMultiSelectTextFormField extends StatefulWidget {
  static const routeName = '/MachineEditMultiSelectTextFormField';

  const MachineEditMultiSelectTextFormField({
    Key? key,
    this.pickedMachineFn,
  }) : super(key: key);
  final void Function(List<MachineListModelDatum> pickedMachine)?
      pickedMachineFn;
  @override
  _MachineEditMultiSelectTextFormFieldState createState() =>
      _MachineEditMultiSelectTextFormFieldState();
}

class _MachineEditMultiSelectTextFormFieldState
    extends State<MachineEditMultiSelectTextFormField> {
  final categoryName = TextEditingController();

  @override
  void initState() {
    Provider.of<MaintainanceProvider>(context, listen: false)
        .emptySelectedListModelDatumSetter();
  }

  @override
  Widget build(BuildContext context) {
    List<MachineListModelDatum> selectedListModelDatum =
        Provider.of<MaintainanceProvider>(context).selectedListModelDatumGetter;
    return LayoutBuilder(
      builder: (context, constraits) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: selectedListModelDatum.isEmpty
              ? InkWell(
                  onTap: () async {
                    final result = await showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      builder: (BuildContext _) {
                        return const ModelSheetofMachinesMultiSelect();
                      },
                      isScrollControlled: true,
                    );
                  },
                  child: const InputDecorator(
                    decoration: InputDecoration(
                      hintText: 'Machines',
                      labelText: 'Select Machines',
                      contentPadding: EdgeInsets.all(18),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () async {
                    final result = await showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      builder: (BuildContext _) {
                        return const ModelSheetofMachinesMultiSelect();
                      },
                      isScrollControlled: true,
                    );
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      hintText: 'Machines',
                      labelText: 'Select Machines',
                      contentPadding: EdgeInsets.all(18),
                    ),
                    child: Wrap(
                      children: selectedListModelDatum
                          .map(
                            (i) => Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                              ),
                              child: InputChip(
                                padding: const EdgeInsets.all(10.0),
                                label: Text(
                                  i.name,
                                  style: TextStyle(
                                      color: i.isSelected
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                selected: i.isSelected,
                                selectedColor: Colors.blue.shade600,
                                onSelected: (bool selected) async {
                                  final result = await showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30)),
                                    ),
                                    builder: (BuildContext _) {
                                      return const ModelSheetofMachinesMultiSelect();
                                    },
                                    isScrollControlled: true,
                                  );
                                },
                                onDeleted: () {
                                  Provider.of<MaintainanceProvider>(context,
                                          listen: false)
                                      .removeSelectedListModelDatumSetter(i);
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class ModelSheetofMachinesMultiSelect extends StatefulWidget {
  const ModelSheetofMachinesMultiSelect({
    Key? key,
  }) : super(key: key);

  @override
  State<ModelSheetofMachinesMultiSelect> createState() =>
      _ModelSheetofMachinesMultiSelectState();
}

class _ModelSheetofMachinesMultiSelectState
    extends State<ModelSheetofMachinesMultiSelect> {
  final ScrollController _listScrollPage = ScrollController();
  final categoryName = TextEditingController(text: 'Select Machine');

  List<MachineListModelDatum>? items = [];
  bool loading = false, allLoaded = false;
  int pageNo = 1;

  mockFetch() async {
    if (allLoaded) {
      return;
    }
    if (!mounted) return; setState(() {
      loading = true;
    });
    await Future.delayed(Duration.zero);
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;

    final responseString = await MaintainanceApiFunction().getMachines(
      locationId.toString(),
      token,
      pageNo,
    );

    final newList = machineListModelFromMap(responseString).data!.data;

    if (newList!.isNotEmpty) {
      if (!mounted) return; setState(() {
        pageNo++;
        for (var item in newList) {
          items!.add(item);
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

  funcCall() {}

  @override
  void dispose() {
    _listScrollPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraits) {
      return StatefulBuilder(builder:
          (BuildContext context, StateSetter setter /*You can rename this!*/) {
        List<MachineListModelDatum> selectedListModelDatum =
            Provider.of<MaintainanceProvider>(
          context,
        ).selectedListModelDatumGetter;
        var selectedListModelDatumProvider =
            Provider.of<MaintainanceProvider>(context, listen: false);

        return SizedBox(
          height: 400,
          child: Column(
            children: [
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width * 2,
              ),
              Text(
                "Machines",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width * 2,
              ),
              if (items!.isNotEmpty)
                Expanded(
                  child: Stack(
                    children: [
                      ListView.separated(
                          controller: _listScrollPage,
                          itemBuilder: (context, index) {
                            selectedListModelDatum.where((element) {
                              if (element.id == items![index].id) {
                                items![index].isSelected = true;
                              }
                              return element.id == items![index].id;
                            }).toList();
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
                                  items![index].name.toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                trailing: (items![index].isSelected)
                                    ? const Icon(
                                        CupertinoIcons.check_mark_circled_solid,
                                        color: Colors.green,
                                      )
                                    : const Icon(
                                        CupertinoIcons.checkmark,
                                        color: Colors.white,
                                      ),
                                onTap: () {
                                  if (!mounted) return; setState(() {
                                    categoryName.text = items![index].name;

                                    items![index].isSelected =
                                        !(items![index].isSelected);
                                    print(
                                        "This is the Selected ${items![index].isSelected}");
                                    if (items![index].isSelected == true) {
                                      selectedListModelDatumProvider
                                          .addSelectedListModelDatumSetter(
                                              items![index]);
                                    } else {
                                      selectedListModelDatumProvider
                                          .removeSelectedListModelDatumSetter(
                                              items![index]);
                                    }
                                  });
                                  Navigator.pop(context, items![index]);
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
