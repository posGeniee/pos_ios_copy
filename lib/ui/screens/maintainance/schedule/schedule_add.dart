import 'dart:io';

import 'package:dummy_app/data/models/maintainance/machines/machine_list_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/maintainance_provider.dart';
import 'package:dummy_app/helpers/helper%20function%20api/maintainance_api_function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/widget.dart';
import 'package:dummy_app/ui/widgets/image_picker_app.dart';
import 'package:dummy_app/ui/widgets/machine_multi_select_form_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:edge_alerts/edge_alerts.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleAdd extends StatefulWidget {
  static const routeName = '/ScheduleAdd';
  const ScheduleAdd({Key? key}) : super(key: key);

  @override
  _ScheduleAddState createState() => _ScheduleAddState();
}

class _ScheduleAddState extends State<ScheduleAdd> {
  final descriptionField = TextEditingController();
  final dateField = TextEditingController();
  File? _userImageFile;
  String? selectedDropDown;
  final _formKey = GlobalKey<FormState>();
  String? dropDownValue;
  int? dropDownValueInt;
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Maintainance Schedule",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          appButttonWithoutAnimationWithoutDecoration(
            context,
            CupertinoIcons.share_up,
            'Save',
            () async {
              List<MachineListModelDatum> selectedListModelDatum =
                  Provider.of<MaintainanceProvider>(context, listen: false)
                      .selectedListModelDatumGetter;
              bool validation = _formKey.currentState!.validate();
              if (validation && selectedListModelDatum.isNotEmpty) {
                showLoading();
                final token = Provider.of<AuthRequest>(context, listen: false)
                    .signiModelGetter
                    .data!
                    .bearer;
                final locationId =
                    Provider.of<AuthRequest>(context, listen: false)
                        .locationFromApiGetter
                        .id;

                if (dropDownValue == null) {
                  await MaintainanceApiFunction().addSchedule(
                    token,
                    locationId.toString(),
                    dateField.text,
                    descriptionField.text,
                    selectedListModelDatum,
                    false,
                  );
                } else {
                  await MaintainanceApiFunction().addSchedule(
                    token,
                    locationId.toString(),
                    dateField.text,
                    descriptionField.text,
                    selectedListModelDatum,
                    true,
                    scheduleValue: dropDownValueInt.toString(),
                  );
                }
                
                dismissLoading();

                Navigator.of(context).pop();
                Navigator.of(context).pop();
                // if (responseString.runtimeType == PartCategoryDatum) {
                //   // Provider.of<MaintainanceProvider>(context, listen: false)
                //   //     .addIndividualForMainScreebListModelDatumSetter(
                //   //         responseString);
                //   dismissLoading();

                //   Navigator.of(context).pop();
                //   Navigator.of(context).pop();
                // } else {
                //   dismissLoading();
                // }
              } else {
                edgeAlert(context,
                    title: 'No Machine Selected', backgroundColor: Colors.red);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: DateTimeField(
                  controller: dateField,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter Date';
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Enter Date', label: Text('Date')),
                  format: formatofDateForViewwithTime,
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.combine(date, time);
                    } else {
                      return currentValue;
                    }
                  },
                ),
              ),
              const MachineEditMultiSelectTextFormField(),
              newAppField(descriptionField, 'Description', TextInputType.name,
                  [], TextInputAction.next,
                  readOnly: false),
              UserImagePicker(
                imagePickFn: _pickedImage,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    hintText: "Select the Schedule",
                  ),
                  value: dropDownValue,
                  onChanged: (value) {
                    setState(() {
                      selectedDropDown = value.toString();
                    });
                    if (selectedDropDown!.contains('Weekly')) {
                      setState(() {
                        dropDownValueInt = 7;
                      });
                    } else if (selectedDropDown!.contains('BiWeekly')) {
                      setState(() {
                        dropDownValueInt = 15;
                      });
                    } else if (selectedDropDown!.contains('Monthly')) {
                      setState(() {
                        dropDownValueInt = 30;
                      });
                    }
                    print("This si the Value Selected $value");
                  },
                  items: ['Weekly', 'BiWeekly', 'Monthly']
                      .map(
                        (cityTitle) => DropdownMenuItem(
                          value: cityTitle,
                          child: Text(cityTitle),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
