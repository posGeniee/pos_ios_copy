import 'package:dummy_app/data/models/maintainance/machines/machine_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';

import 'package:dummy_app/helpers/const.dart';

import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachineEditTextFormField extends StatefulWidget {
  static const routeName = '/MachineEditTextFormField';

  const MachineEditTextFormField({
    Key? key,
    this.pickedMachineFn,
  }) : super(key: key);
  final void Function(MachineListModelDatum pickedMachine)? pickedMachineFn;
  @override
  _MachineEditTextFormFieldState createState() =>
      _MachineEditTextFormFieldState();
}

class _MachineEditTextFormFieldState extends State<MachineEditTextFormField> {
  final categoryName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraits) {
        return TextFormField(
          readOnly: true,
          onTap: () async {
            final result = await showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              builder: (BuildContext _) {
                return const ModelSheetofMachines();
              },
              isScrollControlled: true,
            );
            if (result != null) {
              if (!mounted) return; setState(() {
                final MachineListModelDatum tempResult = result;
                categoryName.text = tempResult.name;
                widget.pickedMachineFn!(tempResult);
              });
            }
          },
          controller: categoryName,
          decoration: const InputDecoration(
            hintText: 'None Selected',
            labelText: 'Machines',
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

class ModelSheetofMachines extends StatefulWidget {
  const ModelSheetofMachines({
    Key? key,
  }) : super(key: key);

  @override
  State<ModelSheetofMachines> createState() => _ModelSheetofMachinesState();
}

class _ModelSheetofMachinesState extends State<ModelSheetofMachines> {
  final ScrollController _listScrollPage = ScrollController();
  final categoryName = TextEditingController(text: 'Select Machine');

  List<MachineListModelDatum>? items = [];
  bool loading = false, allLoaded = false;
  int pageNo = 1;
  MachineListModelDatum _selectedListModelDatum = MachineListModelDatum(
    number: '',
    name: '',
    temperature: '',
    id: -1,
    isSelected: false,
    displayUrl: '',
  );
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
                                trailing: (items![index].id ==
                                        _selectedListModelDatum.id)
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
                                    _selectedListModelDatum = items![index];
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
